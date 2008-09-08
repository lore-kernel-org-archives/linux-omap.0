From: David Brownell <david-b@pacbell.net>
Subject: Re: [Resend][PATCH - Omapzoom][NAND] Add prefetch and DMA support
Date: Mon, 8 Sep 2008 15:19:32 -0700
Message-ID: <200809081519.33011.david-b@pacbell.net>
References: <1220897015-14338-1-git-send-email-nskamat@ti.com> <20080908181319.GH8266@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:22296 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752401AbYIHWTf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 18:19:35 -0400
In-Reply-To: <20080908181319.GH8266@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: nskamat@ti.com, linux-omap@vger.kernel.org, Vimal Singh <vimalsingh@ti.com>

On Monday 08 September 2008, Russell King - ARM Linux wrote:
> > -=A0=A0=A0=A0=A0while (len--)
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*p++ =3D cpu_to_le16(readw(=
info->nand.IO_ADDR_R));
>=20
> This driver needs work (see endianness explaination below.)

Already done, but this patch doesn't build on that patch...


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
