From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv5 2/6] ARM: OMAP3 PM: Move IO Daisychain function to omap3
 prm file
Date: Mon, 12 Mar 2012 15:45:21 +0530
Message-ID: <4F5DCCB9.900@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>	 <1331046702-2472-3-git-send-email-t-kristo@ti.com>	 <alpine.DEB.2.00.1203091737390.30879@utopia.booyaka.com>	 <4F5D8EBA.3060602@ti.com> <1331543948.2116.259.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42690 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751638Ab2CLKP3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 06:15:29 -0400
Received: by mail-gx0-f171.google.com with SMTP id s5so2907391ggc.30
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 03:15:28 -0700 (PDT)
In-Reply-To: <1331543948.2116.259.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

Hi Tero,

On Monday 12 March 2012 02:49 PM, Tero Kristo wrote:
>>> I see that you removed the second timeout test from this code, but not
>>> >  >  from the OMAP4 version.  Any reason why?  Seems like if the second timeout
>>> >  >  can be removed from one, then it can also be removed from the other?
>> >
>> >  Actually FWIK, its nteeded in both OMAP3 and OMAP4. The OMAP3
>> >  documentation does no mention about it. but that is just bad
>> >  documentation.
> Both documentation and actual functionality appears to be different for
> OMAP3 / OMAP4. The status bit on OMAP3 is read / write, and writing 1 to
> it clears it. On OMAP4, it is read only and both values 0 / 1 indicate
> something has happened. On OMAP3 the bit must be cleared by writing 1 to
> it, otherwise it remains high indefinitely and will break all the
> subsequent trigger calls. Also, clearing EN_IO_CHAIN on OMAP3 does not
> appear to trigger any activity that would change the status of
> ST_IO_CHAIN, so there is nothing to poll at the end.
>
> Here is a sample trace I just generated for the trigger on OMAP3:
>
> [    7.707824] omap3_trigger_io_chain(1): PM_WKST=00000000
> [    7.707855] omap3_trigger_io_chain(2): PM_WKST=00000000
> [    7.707855] omap3_trigger_io_chain(3): PM_WKST=00010000
> [    7.707885] omap3_trigger_io_chain(4): PM_WKST=00000000
> [    7.707977] omap3_trigger_io_chain(5): PM_WKST=00000000
>
> 1 = enter trigger function
> 2 = just after enabling io chain
> 3 = just after first poll loop
> 4 = just after clear of io status and disabling of io chain
> 5 = after udelay(100) from last event (you can see the status bit never
> raises)

Ok, I guess then the omap3 and omap4 implementations are indeed
different and should be handled differently. Thanks for the explanation.

regards,
Rajendra

>
> So, you can see that there is no change in the status bit between 4...5,
> so there is no point for polling anything there. I even tried changing
> the clear of IO status and disabling of IO chain to see if it had any
> impact on this result but no. The main point is that we must clear the
> status bit at #4, and thus polling for it to change at #5 makes no
> sense. We just need to force the register writes to PRCM by doing some
> access to the IP block.
>
>
> Looking at similar trace on omap4:
>
> [    8.097503] omap4_trigger_io_chain(1): IO=00010020
> [    8.097503] omap4_trigger_io_chain(2): IO=00010320
> [    8.097534] omap4_trigger_io_chain(3): IO=00010320
> [    8.097534] omap4_trigger_io_chain(4): IO=00010020
> [    8.097534] omap4_trigger_io_chain(5): IO=00010020
>
> 1 = enter function
> 2 = just after enabling WUCLK_CTRL
> 3 = just after poll
> 4 = just after disabling WUCLK_CTRL
> 5 = just after poll
>
> Well, the status bit follows the state of the WUCLK_CTRL, but there is
> no time to actually poll the registers it seems, their state has already
> changed when the value from first read arrives back as the register
> access itself is so slow. But... we are not manually clearing the status
> bit, thus polling kind of makes sense (and it might make more sense if
> some future version of PRCM would allow faster register access.)
>
> I also did both of these tests by caching the register values to memory
> (no immediate printks to avoid delays) but the results are still the
> same.
>

