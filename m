From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc3-omap1] omap3 beagle: nand (mostly) cleanups
Date: Fri, 29 Aug 2008 21:23:15 -0700
Message-ID: <200808292123.15916.david-b@pacbell.net>
References: <200808291012.47332.david-b@pacbell.net> <13B9B4C6EF24D648824FF11BE896716203653CA11D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:37000 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750730AbYH3EXS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Aug 2008 00:23:18 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203653CA11D@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 29 August 2008, Woodruff, Richard wrote:
> > Clean up the Beagle NAND config a bit: =A0use SZ_128K instead of
> > an arithmetic expression for the NAND block size. =A0Set the
> > NAND_BUSWIDTH_16 flag. =A0Make its init routine static.
>=20
>=20
> Actually, this was talked about before a bit and the SZ_xyz flags wer=
e left out.
>=20
> The point of telling the geometry in the addition was to be explicit
> about the number of sectors being used.=20

So #define NAND_BLOCK_SIZE SZ_128K and use that symbol instead?

=46rankly N*(64 * 2048) isn't very meaningful.  The comment at the
top already says everything is in units of blocks, but one is  left
to guess that "block" is "(64 * 2048)"...


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
