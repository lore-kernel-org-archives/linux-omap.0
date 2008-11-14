From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] HSMMC: Add MMC configuration for pandora
Date: Fri, 14 Nov 2008 14:35:26 -0800
Message-ID: <200811141435.26574.david-b@pacbell.net>
References: <1226691917-6577-1-git-send-email-notasas@gmail.com> <6ed0b2680811141257g66f451b6k51c9b9c97e67a71b@mail.gmail.com> <5e088bd90811141340o55c88540qd1d75d79baa44bbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:34483 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750936AbYKNWf3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2008 17:35:29 -0500
In-Reply-To: <5e088bd90811141340o55c88540qd1d75d79baa44bbe@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 14 November 2008, Steve Sakoman wrote:
> >> Weren't you working on getting the SDIO WLAN adapter on the third
> >> slot to behave too?
> >
> > yeah, not much progress with that yet, though..
>=20
> Which adapter are you using? =A0I've got the libertas_sdio driver wor=
king on mmc2.

The issue I referred to was the way mmc3 isn't yet
supported at all in that code ...=20



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
