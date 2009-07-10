From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1:2] [MTD][NAND]omap: Adding support for nand prefetch-read  and post-write, in MPU mode.
Date: Fri, 10 Jul 2009 11:01:57 -0700
Message-ID: <200907101101.58029.david-b@pacbell.net>
References: <61339.192.168.10.89.1247226724.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:28968 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751325AbZGJSB7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jul 2009 14:01:59 -0400
In-Reply-To: <61339.192.168.10.89.1247226724.squirrel@dbdmail.itg.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimalsingh@ti.com>
Cc: linux-mtd@lists.infradead.org, Tony Lindgren <tony@atomide.com>, dwmw2@infradead.org, dedekind@infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Friday 10 July 2009, vimal singh wrote:
> +static void omap_read_buf8(struct mtd_info *mtd, u_char *buf, int le=
n)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct nand_chip *nand =3D mtd->priv;
> +=A0=A0=A0=A0=A0=A0=A0u_char *p =3D (u_char *)buf;
> +
> +=A0=A0=A0=A0=A0=A0=A0while (len--)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*p++ =3D __raw_readb(na=
nd->IO_ADDR_R);
> +}

Better as __raw_readsb() yes?  Or maybe ioread8_rep().

=2E.. speaking of which, maybe the MTD layer can finally
default to using the accelerated block PIO calls, now
that ioreadX_rep() is supposed to work on all arches...

Last time I measured, that change alone was worth
something like a 10% speedup.  Maybe more.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
