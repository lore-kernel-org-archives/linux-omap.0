From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
Date: Mon, 22 Feb 2010 13:38:13 -0800
Message-ID: <20100222213813.GV18786@atomide.com>
References: <2C1563023E232C49B9F505633D57C2DA2640D0235C@dlee04.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C417FF8C@dbde02.ent.ti.com>
 <2C1563023E232C49B9F505633D57C2DA2640E02643@dlee04.ent.ti.com>
 <20100222201547.GR18786@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62266 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0BVVhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 16:37:16 -0500
Content-Disposition: inline
In-Reply-To: <20100222201547.GR18786@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anna, Suman" <s-anna@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Clark, Rob" <rob@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

* Tony Lindgren <tony@atomide.com> [100222 12:11]:
> * Anna, Suman <s-anna@ti.com> [100222 12:04]:
> > Hi Santosh,
> > 
> > > -----Original Message-----
> > > From: Shilimkar, Santosh
> > > Sent: Saturday, February 20, 2010 12:53 PM
> > > To: Anna, Suman; linux-omap@vger.kernel.org
> > > Cc: Hiroshi.DOYU@nokia.com; Clark, Rob; Kanigeri, Hari; C.A, Subramaniam
> > > Subject: RE: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
> > > 
> > > > -----Original Message-----
> > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Anna,
> > > > Suman
> > > > Sent: Friday, February 19, 2010 2:37 AM
> > > > To: linux-omap@vger.kernel.org
> > > > Cc: Hiroshi.DOYU@nokia.com; Clark, Rob; Kanigeri, Hari; C.A, Subramaniam
> > > > Subject: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
> > > >
> > > > From 2488815a9facca29e2da3ddd279de441a5de6a58 Mon Sep 17 00:00:00 2001
> > > > From: Suman Anna <s-anna@ti.com>
> > > > Date: Tue, 26 Jan 2010 16:55:29 -0600
> > > > Subject: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
> > > >
> > > > OMAP4 mailbox has a different register set. There is
> > > > no MAILBOX_SYSSTATUS register. The reset is indicated
> > > > with the SOFTRESET bit of the MAILBOX_SYSCONFIG register
> > > > itself. This bit should read 0 for a successful Reset.
> > > > Also, the SOFTRESET bit occupies bit0 and not bit1 as with
> > > > previous generations.
> > > >
> > > > Signed-off-by: Suman Anna <s-anna@ti.com>
> > > > ---
> > > >  arch/arm/mach-omap2/mailbox.c |   38 +++++++++++++++++++++++++++-------
> > > ----
> > > >  1 files changed, 27 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-
> > > omap2/mailbox.c
> > > > index c970cf6..88e9043 100644
> > > > --- a/arch/arm/mach-omap2/mailbox.c
> > > > +++ b/arch/arm/mach-omap2/mailbox.c
> > > > @@ -40,6 +40,7 @@
> > > >  #define AUTOIDLE	(1 << 0)
> > > >  #define SOFTRESET	(1 << 1)
> > > >  #define SMARTIDLE	(2 << 3)
> > > > +#define OMAP4_SOFTRESET	(1 << 0)
> > > >
> > > >  /* SYSSTATUS: register bit definition */
> > > >  #define RESETDONE	(1 << 0)
> > > > @@ -99,17 +100,32 @@ static int omap2_mbox_startup(struct omap_mbox
> > > *mbox)
> > > >  	}
> > > >  	clk_enable(mbox_ick_handle);
> > > >
> > > > -	mbox_write_reg(SOFTRESET, MAILBOX_SYSCONFIG);
> > > > -	timeout = jiffies + msecs_to_jiffies(20);
> > > > -	do {
> > > > -		l = mbox_read_reg(MAILBOX_SYSSTATUS);
> > > > -		if (l & RESETDONE)
> > > > -			break;
> > > > -	} while (!time_after(jiffies, timeout));
> > > > -
> > > > -	if (!(l & RESETDONE)) {
> > > > -		pr_err("Can't take mmu out of reset\n");
> > > > -		return -ENODEV;
> > > > +	if (cpu_is_omap44xx()) {
> > > Not so strong opinion but can we make use of mailbox ip revision instead
> > > of cpu_is_xxxx() check.
> > > 
> > 
> > This may be a better option in the longer-run, but the current mailbox registers are assigned based on the cpu_is_xxxx() macro, and I have used this readily available macro rather doing a new one. Also, note that the IP revision value is not published in the TRM.
> 
> In the long run the most flexible option is to check the revision
> for each device during init.
> 
> Anyways, sounds like that's another patch on top of these patches.

As we probably won't have the hwmod patch done for this merge window,
I've added these except for the one to fix compile warning.

Regards,

Tony
