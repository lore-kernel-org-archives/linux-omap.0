From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESENDING][PATCH 1/2]OMAP3 NAND: Add NAND support on OMAP3430
Date: Mon, 6 Oct 2008 09:37:13 -0700
Message-ID: <200810060937.13668.david-b@pacbell.net>
References: <41054.192.168.10.89.1219747319.squirrel@dbdmail.itg.ti.com> <48232.192.168.10.89.1221127616.squirrel@dbdmail.itg.ti.com> <20081006112039.GF2806@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:28652 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752879AbYJFQhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 12:37:16 -0400
In-Reply-To: <20081006112039.GF2806@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, vimal singh <vimalsingh@ti.com>
Cc: linux-omap@vger.kernel.org

On Monday 06 October 2008, Tony Lindgren wrote:
> > --- linux-omap-2.6_27_08_2008.orig/include/linux/mtd/nand.h
> > +++ linux-omap-2.6_27_08_2008/include/linux/mtd/nand.h
> > @@ -45,7 +45,7 @@
> > =A0 */
> > =A0#define NAND_MAX_OOBSIZE=A0=A0=A0=A0=A064
> > =A0#define NAND_MAX_PAGESIZE=A0=A0=A0=A02048
> > -
> > +#define NAND_BLOCK_SIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0S=
Z_128K
> > =A0/*

This is specific to 3430 SDP though ... there are plenty
of other NAND block sizes in the world.

Suggest moving this definition to board-3430sdp-flash.c
where it's relevant.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
