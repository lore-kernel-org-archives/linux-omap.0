From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH - Omapzoom] [NAND] Add prefetch and DMA support
Date: Mon, 8 Sep 2008 15:17:26 -0700
Message-ID: <200809081517.26360.david-b@pacbell.net>
References: <DFEF307E035C8647B119E6A60DB62D4AEE4F7561@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:20951 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754438AbYIHWR2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 18:17:28 -0400
In-Reply-To: <DFEF307E035C8647B119E6A60DB62D4AEE4F7561@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kamat, Nishant" <nskamat@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Singh, Vimal" <vimalsingh@ti.com>

On Monday 08 September 2008, Kamat, Nishant wrote:
> - =A0 =A0 =A0 while (len--)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D cpu_to_le16(readw(info->nand.I=
O_ADDR_R));
> + =A0 =A0 =A0 if (use_prefetch) {

Em, clearly this does not go on top of the NAND patch I
sent recently ... please do that instead, so we don't
need to repeat the cleanups.

  http://marc.info/?l=3Dlinux-omap&m=3D122021756032341&w=3D2


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
