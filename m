From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] TWL6040 MFD and followups
Date: Thu, 7 Jul 2011 11:29:47 -0700
Message-ID: <20110707182947.GM5783@atomide.com>
References: <5898202.Q4JP1WeJj2@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:33067 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755151Ab1GGS3y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 14:29:54 -0400
Content-Disposition: inline
In-Reply-To: <5898202.Q4JP1WeJj2@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com> [110707 04:43]:
> Hello Tony,
>=20
> As it has been discussed I'm sending this pull request, which include=
s the
> following series (all patch acked-by the corresponding maintainer):
> 1. v6 of MFD/ASoC/Input: TWL4030/TWL60X0 changes (18 patch)
> 2. v3 of MFD/input/ASoC: twl6040: irq registration changes (5 patch)
> 3. v1 of ASoC/MFD: twl6040: PLL handling changes (6 patch)
> 4. ASoC: twl6040: Add back support for legacy mode (single patch)
>=20
> The first series starts with a cleanup in the mach-omap2 directory
> (twl-common.c file created), and that is the reason we agreed that yo=
u
> are going to take this pull request.
> The rest of the changes are well contained, and should not cause merg=
e
> conflict for 3.1. We have not sent patches for these components, so t=
he
> changes to these are coming from one source.
>=20
> As you have requested I have created the series on top of your
> devel-cleanup branch.

Thanks. Can you please add one more branch for cleanup only for me to
pull at your commit b252b0efb605b92a2f5d118e294d088d89cfd286
(OMAP3: Move common regulator configuration to twl-common)?

That way I can first pull that into cleanup and send that to Arnd.
Then we can do a separate twl-asoc branch so the cleanup stays
separate from new code.

I don't think there's a way for me to do a pull that ends at certain
commit with git.. Or at least I don't know how to do that short of
git reset --hard of some branch at that commit.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
