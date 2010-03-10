From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: kernel panic with latest DSS
Date: Wed, 10 Mar 2010 10:16:03 -0800
Message-ID: <5e088bd91003101016s4148751es1a142c21d1540564@mail.gmail.com>
References: <5e088bd91003091158l6cfa0b76u204e5432389d573@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:45886 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932672Ab0CJSQE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 13:16:04 -0500
Received: by qw-out-2122.google.com with SMTP id 9so169027qwb.37
        for <linux-omap@vger.kernel.org>; Wed, 10 Mar 2010 10:16:03 -0800 (PST)
In-Reply-To: <5e088bd91003091158l6cfa0b76u204e5432389d573@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>

On Tue, Mar 9, 2010 at 11:58 AM, Steve Sakoman <sakoman@gmail.com> wrot=
e:
> I just updated all my Beagle and Overo DSS patches to apply on the
> latest linux-omap head.
>
> I ran into a slight issue with parsing defaults, but saw that Tomi ha=
d
> already posted a workaround for that.
>
> With that patch applied I get pretty good results until I try to do
> something like play a DVD or display video from a webcam.
>
> At that point I get a kernel panic. =A0See below.

I did a little more research on this.

The issue occurs in the following section of code in
drivers/video/omap2/dss/dispc.c:

unsigned long dispc_fclk_rate(void)
{
	unsigned long r =3D 0;

	if (dss_get_dispc_clk_source() =3D=3D DSS_SRC_DSS1_ALWON_FCLK)
		r =3D dss_clk_get_rate(DSS_CLK_FCK1);
	else
#ifdef CONFIG_OMAP2_DSS_DSI
		r =3D dsi_get_dsi1_pll_rate();
#else
	BUG();
#endif
	return r;
}

Since my machines don't have DSI displays CONFIG_OMAP2_DSS_DSI is not
defined and the BUG() call is triggered.

I don't know enough about what *should* be happening here to propose a
fix, but I'll continue looking.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
