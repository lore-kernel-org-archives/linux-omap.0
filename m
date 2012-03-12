From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv5 2/6] ARM: OMAP3 PM: Move IO Daisychain function to omap3
 prm file
Date: Mon, 12 Mar 2012 11:20:50 +0530
Message-ID: <4F5D8EBA.3060602@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-3-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1203091737390.30879@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:37972 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218Ab2CLFu6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 01:50:58 -0400
Received: by mail-yw0-f52.google.com with SMTP id p61so2222973yhp.25
        for <linux-omap@vger.kernel.org>; Sun, 11 Mar 2012 22:50:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1203091737390.30879@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Saturday 10 March 2012 06:10 AM, Paul Walmsley wrote:
> cc Rajendra
>
> Hi Tero,
>
> a few comments:
>
> On Tue, 6 Mar 2012, Tero Kristo wrote:
>
> ...
>
>> +/* OMAP3 Daisychain enable sequence */
>> +void omap3_trigger_io_chain(void)
>> +{
>> +	int i = 0;
>> +
>> +	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
>> +				   PM_WKEN);
>> +	/* Do a readback to assure write has been done */
>> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
>
> Looks like this barrier shouldn't be needed?  The write is immediately
> followed by another read from the same IP block.
>
>> +
>> +	omap_test_timeout(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST)&
>> +			  OMAP3430_ST_IO_CHAIN_MASK,
>> +			  MAX_IOPAD_LATCH_TIME, i);
>> +
>> +	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
>> +				     PM_WKEN);
>> +
>> +	omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK, WKUP_MOD,
>> +				     PM_WKST);
>> +
>> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST);
>> +}
>
> I see that you removed the second timeout test from this code, but not
> from the OMAP4 version.  Any reason why?  Seems like if the second timeout
> can be removed from one, then it can also be removed from the other?

Actually FWIK, its nteeded in both OMAP3 and OMAP4. The OMAP3
documentation does no mention about it. but that is just bad
documentation.

>
>
> - Paul

