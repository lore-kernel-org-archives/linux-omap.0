From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] MTD: NAND: ams-delta: select for built-in by default
Date: Sun, 19 Dec 2010 19:00:53 +0200
Message-ID: <1292778053.13362.7.camel@koala>
References: <201012151258.16764.jkrzyszt@tis.icnet.pl>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:64331 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab0LSRBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Dec 2010 12:01:04 -0500
Received: by bwz16 with SMTP id 16so2602757bwz.4
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 09:01:02 -0800 (PST)
In-Reply-To: <201012151258.16764.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, 2010-12-15 at 12:58 +0100, Janusz Krzysztofik wrote:
> Now that the Amstrad Delta NAND driver is converted to a platform dri=
ver,=20
> which prevents it from interfering with other unrelated hardware in m=
ultiple=20
> OMAP1 cpu and machine configurations, it can be automatically configu=
red for=20
> being built into the kernel if the Amstrad Delta board is also select=
ed.
>=20
> Created against linux-2.6.37-rc5.
>=20
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Pushed to l2-mtd-2.6.git, thanks.

--=20
Best Regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
