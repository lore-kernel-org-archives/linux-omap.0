From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP3:devices.c: Enabling 4-bit for SD card
Date: Tue, 5 Aug 2008 00:10:14 -0700
Message-ID: <200808050010.15117.david-b@pacbell.net>
References: <200806161302.m5GD2Xg4007641@india.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301118F2774@dbde02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB5930111B215C5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:39124 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760352AbYHEHKR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 03:10:17 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930111B215C5@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kumar, Purushotam" <purushotam@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Purushotam Kumar <a0876542@india.ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>

On Monday 14 July 2008, Kumar, Purushotam wrote:
> > > > =A0 =A0 =A0 if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> > > > - =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->enabled)
> > > > + =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->enabled) {
> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc1_data.conf =3D *m=
mc;
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void) platform_dev=
ice_register(&mmc_omap_device1);
> > > > + =A0 =A0 =A0 =A0 =A0 =A0 }

I don't get it.  OMAP3 uses the hsmmc code, which uses
a "struct omap_mmc_platform_data" to configure itself.

But this patch updates a "struct omap_mmc_conf" as used
by the non-hsmmc code.

So ... it's a NOP, at least for OMAP3.  Right?


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
