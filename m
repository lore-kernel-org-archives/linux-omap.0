From: David Brownell <david-b@pacbell.net>
Subject: Re: Question regarding OMAP NAND driver read_buf16() function
Date: Thu, 20 Nov 2008 12:53:43 -0800
Message-ID: <200811201253.43961.david-b@pacbell.net>
References: <1227208386.27896.239.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:48948 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756887AbYKTUxq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 15:53:46 -0500
In-Reply-To: <1227208386.27896.239.camel@blackhole>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter@the-baradas.com>
Cc: linux-omap@vger.kernel.org

On Thursday 20 November 2008, Peter Barada wrote:
> In drivers/mtd/nand/omap2.c, I see the call to __raw_readsl:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0__raw_readsl(nand->IO_ADDR_R, buf, len / 2);
>=20
> Since len is in bytes (from the comment), shouldn't this either be:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0__raw_readsl(nand->IO_ADDR_R, buf, len / 4);
>=20
> or:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0__raw_readsw(nand->IO_ADDR_R, buf, len / 2);
> =A0=A0=A0=A0=A0=A0=A0=A0

Current GIT has the latter.  Upgrde your kernel.  ;)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
