From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH] [OMAP] GPIO Module is reset during initialization
Date: Mon, 26 Oct 2009 06:04:10 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AC2284E@dlee02.ent.ti.com>
References: <1256313329-24996-1-git-send-email-charu@ti.com>
 <20091023225639.GA13020@gandalf>,<4AE24C60.6040302@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADE8@dbde02.ent.ti.com>,<7A436F7769CA33409C6B44B358BFFF0C012AC22838@dlee02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADEA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55491 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755558AbZJZLEP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 07:04:15 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADEA@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charu Latha" <charu@ti.com>, "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Varadarajan, Charu Latha
> Sent: Monday, October 26, 2009 5:52 AM
> To: Menon, Nishanth; me@felipebalbi.com
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] [OMAP] GPIO Module is reset during initialization
> 
> -----snippet----
> >>>>
> >>>> && attemp)
> >>>>
> >>>>> +                    udelay(1);
> >>>>
> >>>> i guess cpu_relax() is better here.
> >> I guess cpu_relax is not required because this part of code is called
> only
> >> from
> >> board file during boot-up. Hence this would be the only code to be
> >> executed.
> What is your opinion on this?
Cpu_relax is still the better way of doing it.

> >>>>
> >>>>> +                    attempt++;
> >>>>>
> >>>>> attempt--;
> >>>>>
> >>>>cant we improve this code as following:
> >>>{
> >>>        u8 attempts = 25;
> >>>        /* Software Reset of GPIO module */
> >>>        __raw_writel(0x0002, bank->base
> >>>                                + OMAP24XX_GPIO_SYSCONFIG);
> >>>        /* wait for reset to be done */
> >>>        while (((__raw_readl(bank->base +
> >>>                        OMAP24XX_GPIO_SYSSTATUS) & 0x1) == 0)
> >>>                        && attempts) {
> >>>                cpu_relax();
> >>>                if (attempts % 5)
> >>>                        udelay(1);
> >>>                attempts--;
> >>>        }
> >>>
> >>>allows the kernel to do somethin else while we also ensure we have a 5
> >>>usec guarenteed delay before giving up..
> >> Doesn't modulo operation cost more in terms of performance?  Any
> specific
> >> reason for specific 5 microseconds?
> >You could replace it with >> operator if you like and use 2^x multiples..
> >I am just sticking 5 us there based on your original code..
> >so the same logic over here I suppose.. unless I missed something?
> I was using attempts as 5, as my intension was to attempt only 5 times and
> not
> in terms  of usec as I could not find any details in any document for
> maximum
> time for the bit to get set/reset. According to your code, it would
> attempt to read
> the register 25 times with a delay of 5 microseconds min during worst case
> scenario.
Please find the h/w timeout value and resubmit the patch..

Regards,
Nishanth Menon

