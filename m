From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] OMAP: hsmmc: fix memory leak
Date: Wed, 10 Feb 2010 15:28:11 +0200
Message-ID: <1265808491.2006.226.camel@localhost>
References: <1265632385-27448-1-git-send-email-aaro.koskinen@nokia.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23343 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab0BJN26 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 08:28:58 -0500
In-Reply-To: <1265632385-27448-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, adrian.hunter@nokia.com, jarkko.lavinen@nokia.com

On Mon, 2010-02-08 at 14:33 +0200, Aaro Koskinen wrote:
> The platform data allocated with kmalloc() will become unreachable on=
ce
> the init is complete, so it should be freed. The problem was discover=
ed
> by kmemleak.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

You forgot to add:

Acked-by: Adrian Hunter <adrian.hunter@nokia.com>

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
