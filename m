From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESENDING][PATCH 1/2]OMAP3 NAND: Add NAND support on OMAP3430
Date: Wed, 10 Sep 2008 23:21:43 -0700
Message-ID: <200809102321.44169.david-b@pacbell.net>
References: <41054.192.168.10.89.1219747319.squirrel@dbdmail.itg.ti.com> <33923.192.168.10.89.1221112794.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:20356 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751483AbYIKGVq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Sep 2008 02:21:46 -0400
In-Reply-To: <33923.192.168.10.89.1221112794.squirrel@dbdmail.itg.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimalsingh@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Wednesday 10 September 2008, vimal singh wrote:
> [VS: updated for SZ_.. macros]

> +=A0=A0=A0=A0=A0=A0=A0/* All the partition sizes are listed in terms =
of NAND block size
> ...
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.size =A0 =A0 =A0 =A0 =A0=
 =3D SZ_512K,
> ...
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.size =A0 =A0 =A0 =A0 =A0=
 =3D SZ_512K,
> ...

But now they're not "in terms of NAND block size".

Wouldn't it be better to use either 4 * SZ_128K or 4 * NAND_BLOCK_SIZE?

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
