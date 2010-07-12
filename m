From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 2/2] omap3: sr: improve errors handling
Date: Mon, 12 Jul 2010 16:36:41 +0300
Message-ID: <1278941801.16634.83.camel@localhost>
References: <1278681612-10521-1-git-send-email-dedekind1@gmail.com>
	 <1278681612-10521-2-git-send-email-dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50650 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab0GLNmB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jul 2010 09:42:01 -0400
In-Reply-To: <1278681612-10521-2-git-send-email-dedekind1@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>, Peter p2 De Schrijver <peter.de-schrijver@nokia.com>

On Fri, 2010-07-09 at 16:20 +0300, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>=20
> Do not forget to check the 'platform_device_add_data()' error code
> in 'omap_device_build_ss()'.
>=20
> Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

Please, discard this patch, I'll send a new one with amended subject.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
