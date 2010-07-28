From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
Date: Wed, 28 Jul 2010 11:45:42 +0200
Message-ID: <201007281145.43450.laurent.pinchart@ideasonboard.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com> <19F8576C6E063C45BE387C64729E7394044ED6384D@dbde02.ent.ti.com> <513FF747EED39B4AADBB4D6C9D9F9F7903D644D974@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.irobotique.be ([92.243.18.41]:45170 "EHLO
	perceval.irobotique.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab0G1JpE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 05:45:04 -0400
In-Reply-To: <513FF747EED39B4AADBB4D6C9D9F9F7903D644D974@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Sin, David" <davidsin@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <rmk@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Molnar, Lajos" <molnar@ti.com>

Hi,

On Tuesday 27 July 2010 21:05:11 Sin, David wrote:
> On Tuesday 27 July 2010 13:38:00 Hiremath, Vaibhav wrote:
> > On Saturday 24 July 2010 04:52:00 Sin, David wrote:
> > > 
> > > This patch adds support for DMM-PAT initialization and programming.
[snip]

> > > diff --git a/arch/arm/mach-omap2/include/mach/dmm.h b/arch/arm/mach-
> > > omap2/include/mach/dmm.h
> > > new file mode 100644
> > > index 0000000..68b798a
> > > --- /dev/null
> > > +++ b/arch/arm/mach-omap2/include/mach/dmm.h
> > > @@ -0,0 +1,128 @@

[snip]

> > > +#define DMM_PAT_STATUS__0     0x4C0
> > > +#define DMM_PAT_STATUS__1     0x4C4
> > > +#define DMM_PAT_STATUS__2     0x4C8
> > > +#define DMM_PAT_STATUS__3     0x4CC
> > > +#define DMM_PAT_DESCR__0      0x500
> > > +#define DMM_PAT_AREA__0       0x504
> > > +#define DMM_PAT_CTRL__0       0x508
> > > +#define DMM_PAT_DATA__0       0x50C
> > 
> > [Hiremath, Vaibhav] Not sure whether somebody has given same comment or
> > not, any specific reason behind double _ here?
> 
> [dhs] Yes -- this comment has been made already.  I'm using the same names
> defined in the TRM.  However, it can be changed.

If the TRM uses two underscores I'm fine with it.

-- 
Regards,

Laurent Pinchart
