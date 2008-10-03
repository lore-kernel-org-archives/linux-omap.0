From: "Anand Gadiyar" <gadiyar@gmail.com>
Subject: Re: [patch 2.6.27-rc8-omap 0/7] resend of pending TWL patches
Date: Fri, 3 Oct 2008 23:08:51 +0530
Message-ID: <57969b5c0810031038w34f02dafxbc664f58cf5965ba@mail.gmail.com>
References: <200810030857.37888.david-b@pacbell.net>
	 <200810030942.28540.david-b@pacbell.net>
	 <57969b5c0810031036q55075fdbw259159757f25c863@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.251]:30219 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbYJCRiw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 13:38:52 -0400
Received: by hs-out-0708.google.com with SMTP id 4so523058hsl.5
        for <linux-omap@vger.kernel.org>; Fri, 03 Oct 2008 10:38:51 -0700 (PDT)
In-Reply-To: <57969b5c0810031036q55075fdbw259159757f25c863@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

(Hit reply instead of reply-all... Reminder to self. Never send emails
when you're sleepy)

On Fri, Oct 3, 2008 at 11:06 PM, Anand Gadiyar <gadiyar@gmail.com> wrote:
> On Fri, Oct 3, 2008 at 10:12 PM, David Brownell <david-b@pacbell.net> wrote:
>> On Friday 03 October 2008, David Brownell wrote:
>>> This flushes my queue of TWL (and related) patches that
>>> seem ready to merge:
>>
>> Sanity tested on Beagle, FYI.
>>
>> Where I observed a new oddity:  the boot hung right after
>> listing the MTD partitions.  Which is where the EHCI code
>> would come up ... took that driver out of the build, and
>> the hang went away.  Clue, oh clue; where art thou?
>>
>
> Well... Any chance this bit of code here helps? This infinite loop
> shouldn't even have been here. Oh well.
>
>
> ====CUT_HERE=====
> Remove infinite loop in DPLL 5 programming. Ideally, DPLL5 should be
> taken care of by the clock framework.
> ---
>  drivers/usb/host/ehci-omap.c |    2 ++
>  1 files changed, 2 insertions(+)
>
> Index: linux-omap-2.6/drivers/usb/host/ehci-omap.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/usb/host/ehci-omap.c    2008-09-18
> 14:59:34.000000000 +0530
> +++ linux-omap-2.6/drivers/usb/host/ehci-omap.c 2008-09-18
> 15:00:09.737475758 +0530
> @@ -170,10 +170,12 @@ static int omap_start_ehc(struct platfor
>                        (7 << OMAP3430ES2_EN_PERIPH2_DPLL_SHIFT),
>                        PLL_MOD, OMAP3430ES2_CM_CLKEN2);
>
> +#if 0
>        while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
>                                OMAP3430ES2_ST_PERIPH2_CLK_MASK))
>                dev_dbg(hcd->self.controller, "idlest2 = 0x%x\n",
>                        cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
> +#endif
>        /* End DPLL5 programming */
>
