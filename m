From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
 read/write
Date: Mon, 25 Oct 2010 10:54:33 +0300
Message-ID: <1287993273.2224.4.camel@localhost>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	 <1285063280-4057-10-git-send-email-manjugk@ti.com>
	 <7A436F7769CA33409C6B44B358BFFF0C014F74831E@dlee02.ent.ti.com>
	 <20101007185630.GA26435@n2100.arm.linux.org.uk>  <4CAE2475.4090607@ti.com>
	 <1287964909.5674.22.camel@macbook.infradead.org>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34194 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab0JYH5m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Oct 2010 03:57:42 -0400
Received: by bwz11 with SMTP id 11so2082999bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Oct 2010 00:57:41 -0700 (PDT)
In-Reply-To: <1287964909.5674.22.camel@macbook.infradead.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, 2010-10-25 at 01:01 +0100, David Woodhouse wrote:
> On Thu, 2010-10-07 at 14:50 -0500, Nishanth Menon wrote:
> > my comment being that by moving {read,write}[wlb] to __raw versions=
 dont=20
> > solve the real issue of namespace here. fix should be in=20
> > arch/arm/include/asm/io.h IMHO. so that there are no overlaps as th=
is.=20
>=20
> Indeed. This patch is complete nonsense.

Removing from my l2 tree.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
