From: Michael Lawnick <ml.lawnick@gmx.de>
Subject: Re: [PATCH] i2c: omap: improve duty cycle on SCL
Date: Wed, 17 Jun 2015 13:09:53 +0200
Message-ID: <55815581.80807@gmx.de>
References: <1434482276-1210-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:64708 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbbFQLKW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 07:10:22 -0400
In-Reply-To: <1434482276-1210-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, wsa@the-dreams.de
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Am 16.06.2015 um 21:17 schrieb Felipe Balbi:
> With this patch we try to be as close to 50%
> duty cycle as possible. The reason for this
> is that some devices present an erratic behavior
> with certain duty cycles.
>
> One such example is TPS65218 PMIC which fails
> to change voltages when running @ 400kHz and
> duty cycle is lower than 34%.
>
> The idea of the patch is simple:
>
> calculate desired scl_period from requested scl
> and use 50% for tLow and 50% for tHigh.
=2E..
Hmm, and what's about  Philips I2C specification 2.1, Jan 2000, Table 5=
?

> PARAMETER                       SYMBOL  STANDARD-MODE   FAST-MODE    =
 UNIT
>                                           MIN. MAX.     MIN. MAX.
> LOW period of the SCL clock     tLOW      4.7   =E2=80=93       1.3  =
 =E2=80=93       =C2=B5s
> HIGH period of the SCL clock    tHIGH     4.0   =E2=80=93       0.6  =
 =E2=80=93       =C2=B5s

Your signal is in spec (0.85 =C2=B5s high, 1,65 low).
Maybe your TPS65218 is just buggy or signals are bad?

--=20

KR
Michael

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
