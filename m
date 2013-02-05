From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM:omap2: using strlcpy instead of strncpy
Date: Tue, 5 Feb 2013 10:56:48 -0800
Message-ID: <20130205185648.GM25185@atomide.com>
References: <51090829.1010109@asianux.com>
 <20130201224546.GG22517@atomide.com>
 <510F78AB.4000602@ti.com>
 <20130204181844.GP22517@atomide.com>
 <51106BF2.7080203@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:13305 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755184Ab3BES4y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 13:56:54 -0500
Content-Disposition: inline
In-Reply-To: <51106BF2.7080203@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Chen Gang <gang.chen@asianux.com> [130204 18:22]:
> =E4=BA=8E 2013=E5=B9=B402=E6=9C=8805=E6=97=A5 02:18, Tony Lindgren =E5=
=86=99=E9=81=93:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [130204 01:04]:
> >> > Hi Tony,
> >> >=20
> >> > I can create a branch for you in our gitorious tree
> >> > (git://gitorious.org/omap-audio/linux-audio.git) for this patch.=
 But I think
> >> > for now it would be best if you could take this via linux-omap (=
the file is
> >> > under arch/arm/mach-omap2 anyways)
> > OK thanks I'll apply with your ack to omap-for-v3.9/fixes-noncritic=
al.
> >=20
> > Tony
> >=20
>=20
>   Does it mean: we need not sync MAINTAINERS file for twl-*, recently=
 ?
>=20
>   :-)

No we should still do it.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
