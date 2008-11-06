From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Fix McBSP spin_lock deadlock.
Date: Wed, 5 Nov 2008 17:16:22 -0800
Message-ID: <20081106011621.GJ21736@atomide.com>
References: <1225886429-28058-1-git-send-email-stanley.miao@windriver.com> <200811051546.51707.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64556 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbYKFBQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 20:16:25 -0500
Content-Disposition: inline
In-Reply-To: <200811051546.51707.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081105 15:53]:
> On Wednesday 05 November 2008, Stanley.Miao wrote:
> > @@ -333,7 +333,8 @@ struct omap_mcbsp_platform_data {
> > =A0=A0=A0=A0=A0=A0=A0=A0u8 dma_rx_sync, dma_tx_sync;
> > =A0=A0=A0=A0=A0=A0=A0=A0u16 rx_irq, tx_irq;
> > =A0=A0=A0=A0=A0=A0=A0=A0struct omap_mcbsp_ops *ops;
> > -=A0=A0=A0=A0=A0=A0=A0char const *clk_name;
> > +=A0=A0=A0=A0=A0=A0=A0char const *ick_name;
> > +=A0=A0=A0=A0=A0=A0=A0char const *fck_name;
> > =A0};
> > =A0
> > =A0struct omap_mcbsp {
>=20
> I thought the idea was to fix this using the clock aliasing
> facility ... so that the mcbsp driver would just
>=20
> 	ick =3D clk_get(dev, "ick");
> 	fck =3D clk_get(dev, "fck");
>=20
> (with IS_ERR checks of course) and the platform data would
> no longer need to hold those names.
>=20
> That approach can work on OMAP1 too ... I think this patch
> breaks OMAP1 boards.

Russell also has some ideas, so despite the nasty bug, let's put
the clock aliasing and virtual clocks stuff on hold for a little
while. Meanwhile, maybe we can just add some function for the
virtual clock that does not cause the recursion?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
