From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 01/13] DSPBRIDGE: Replace mem_calloc() by kzalloc() or
 __vmalloc()
Date: Sun, 11 Apr 2010 18:00:11 +0300
Message-ID: <1270998011.2532.3.camel@localhost.localdomain>
References: <818EF96F5A7CC84789DD014773DB09548F6481CB@dlee01.ent.ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:30093 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab0DKPAR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Apr 2010 11:00:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so929032fgg.1
        for <linux-omap@vger.kernel.org>; Sun, 11 Apr 2010 08:00:14 -0700 (PDT)
In-Reply-To: <818EF96F5A7CC84789DD014773DB09548F6481CB@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On Thu, 2010-04-08 at 18:43 -0500, Gomez Castellanos, Ivan wrote:
> From 0306e1ff7c9160dbc5eb9fffcd789a40bea0debb Mon Sep 17 00:00:00 200=
1
> From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
> Date: Fri, 19 Mar 2010 16:43:26 -0600
> Subject: [PATCH 01/13] DSPBRIDGE: Replace mem_calloc() by kzalloc() o=
r __vmalloc()
>=20
> This is needed because the file drivers/dsp/bridge/services/mem.c
> is going to be deleted. The changes should be as follows:
>=20
> mem_calloc(x, MEM_PAGED) =3D=3D> kzalloc(x, GFP_KERNEL)

Hi, I guess you noticed by now that you should not assume kzalloc
returns "paged" memory?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
