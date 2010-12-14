From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] MTD: NAND: ams-delta: convert to platform driver
Date: Tue, 14 Dec 2010 19:00:23 +0200
Message-ID: <1292346023.2538.103.camel@localhost>
References: <201012111840.05270.jkrzyszt@tis.icnet.pl>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:58725 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759214Ab0LNRAy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 12:00:54 -0500
Received: by ewy10 with SMTP id 10so523949ewy.4
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 09:00:53 -0800 (PST)
In-Reply-To: <201012111840.05270.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-mtd@lists.infradead.org, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org

On Sat, 2010-12-11 at 18:40 +0100, Janusz Krzysztofik wrote:
> In its current form, the driver may break unrelated machines if built=
 into the=20
> kernel, hence is not suitable for inclusion into a kernel built for m=
ultiple=20
> OMAP1 machines. Convert it to a platform driver, that should be free =
from that=20
> issue.
>=20
> While being at it, get rid of depreciated omap_read/write(), use iore=
map()=20
> instead.
>=20
> Created and tested against linux-2.6.37-rc5 on Amstrad Delta.
>=20
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Sorry, but would it please be possible to split this few small patches =
-
this one is too difficult to review, at least for me.

Thanks!

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
