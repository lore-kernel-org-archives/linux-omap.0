From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] Backlight driver for omap3evm
Date: Tue, 10 Feb 2009 22:52:16 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA81B8D2@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301BB7E0701@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58105 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbZBJRWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 12:22:39 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301BB7E0701@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Wednesday, January 07, 2009 8:52 PM
> To: Richard Purdie
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] Backlight driver for omap3evm
> 
> 
> > -----Original Message-----
> > From: Richard Purdie [mailto:rpurdie@rpsys.net]
> > Sent: Wednesday, January 07, 2009 8:37 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] Backlight driver for omap3evm
> >
> > On Wed, 2009-01-07 at 20:25 +0530, Sanjeev Premi wrote:
> > should be done in the platform code for the board, not in the
> > general driver. If you do that, you should be able to reuse
> > most of the generic-bl device code.
> 
> I tried so, but wasn't able to get the Kconfig dependencies right to
> get 'generic-bl' into my build. Hence, removed the code that I
> believed to be generic (since yesterday's mail) and created the
> patch.
> 
> Will give another try.
> 
[Hiremath, Vaibhav] Now I will be following up for OMAP3EVM backlight driver patch initiated/posted by Sanjeev. I was just referring to the backlight drives currently available under Linux tree, and observed that almost all drivers have been implemented in different way. I could not able to get one driver to which I can refer to for adding support for OMAP3EVM backlight driver.

Can anybody tell me the expected way of implementation for backlight driver is?

I have some questions here,

	- If I understand correctly (and as mentioned and pointed out by Richard in the mail-chain), platform_device should get added in platform file where it registers the pointer to the structure "struct generic_bl_info". 
This I believe should be standard way everybody should follow, which is not the case.
Am I missing something here?

	- The below question may sound foolish, but to is important for me to understand the framework.

If I have simple and straight control of backlight, do I really required to have separate backlight driver for my platform? Can I make use of generic-bl driver?
The only difference (atleast to my platform) would be the SYSFS entry, the entry will get created something like
/sys/class/backlight/generic-bl/

Is it required to make driver, Power aware and differentiate from generic driver?

Do we have any document on backlight driver framework?

> >
> > Regards,
> >
> > Richard
> >
> >
> > --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

