From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v2] MTD: NAND: ams-delta: convert to platform driver
Date: Wed, 15 Dec 2010 11:37:45 +0200
Message-ID: <1292405865.2512.28.camel@localhost>
References: <201012111840.05270.jkrzyszt@tis.icnet.pl>
	 <1292346023.2538.103.camel@localhost>
	 <201012142109.42784.jkrzyszt@tis.icnet.pl>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:52900 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab0LOJiQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 04:38:16 -0500
Received: by bwz16 with SMTP id 16so1999248bwz.4
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 01:38:15 -0800 (PST)
In-Reply-To: <201012142109.42784.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-mtd@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org

On Tue, 2010-12-14 at 21:09 +0100, Janusz Krzysztofik wrote:
> In its current form, the driver may interfere with different hardware=
 on=20
> different boards if built into the kernel, hence is not suitable for=20
> inclusion into a defconfig, inteded to be usable with multiple OMAP1 =
cpu and=20
> machine types.
>=20
> Convert it to a platform driver, that should be free from this issue.
>=20
> Created and tested against linux-2.6.37-rc5 on Amstrad Delta.
>=20
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Pushed to l2-mtd-2.6.git, thanks!

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
