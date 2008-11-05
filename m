From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: Fix McBSP spin_lock deadlock.
Date: Wed, 5 Nov 2008 15:46:51 -0800
Message-ID: <200811051546.51707.david-b@pacbell.net>
References: <1225886429-28058-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:26035 "HELO
	smtp103.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752510AbYKEXxd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 18:53:33 -0500
In-Reply-To: <1225886429-28058-1-git-send-email-stanley.miao@windriver.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 05 November 2008, Stanley.Miao wrote:
> @@ -333,7 +333,8 @@ struct omap_mcbsp_platform_data {
> =A0=A0=A0=A0=A0=A0=A0=A0u8 dma_rx_sync, dma_tx_sync;
> =A0=A0=A0=A0=A0=A0=A0=A0u16 rx_irq, tx_irq;
> =A0=A0=A0=A0=A0=A0=A0=A0struct omap_mcbsp_ops *ops;
> -=A0=A0=A0=A0=A0=A0=A0char const *clk_name;
> +=A0=A0=A0=A0=A0=A0=A0char const *ick_name;
> +=A0=A0=A0=A0=A0=A0=A0char const *fck_name;
> =A0};
> =A0
> =A0struct omap_mcbsp {

I thought the idea was to fix this using the clock aliasing
facility ... so that the mcbsp driver would just

	ick =3D clk_get(dev, "ick");
	fck =3D clk_get(dev, "fck");

(with IS_ERR checks of course) and the platform data would
no longer need to hold those names.

That approach can work on OMAP1 too ... I think this patch
breaks OMAP1 boards.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
