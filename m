From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP2 NAND: Fix __raw_readsl() length argument
Date: Wed, 22 Oct 2008 15:02:52 -0700
Message-ID: <200810221502.53045.david-b@pacbell.net>
References: <a46a26fd0810221358l6153c0dat74f76af99fc8afaf@mail.gmail.com> <200810221446.11415.david-b@pacbell.net> <a46a26fd0810221452x1edfead1l524270ddaf250e2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:32954 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752806AbYJVWCz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2008 18:02:55 -0400
In-Reply-To: <a46a26fd0810221452x1edfead1l524270ddaf250e2a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 22 October 2008, Juha Kuikka wrote:
> >> - =A0 =A0 =A0 __raw_readsl(nand->IO_ADDR_R, buf, len / 2);
> >> + =A0 =A0 =A0 __raw_readsl(nand->IO_ADDR_R, buf, len / 4);
> >> =A0}
> >
> > Shouldn't that have been __raw_readsw() though?
>
> Hmh, good point.

Yeah, but the bug was from a patch from me ... sigh.

=20
> From the original code it looks like that was the intention but
> readsl() works just as well.

Really?  Both upper and lower 16-bit units have the right data?


> I tested this on OMAP2430 and it works ok.
>=20
> I don't see any mentions in the TRM about the width of the
> GPMC_NAND_DATA registers but apparently the NAND engine happily
> accepts 32bit accesses on bus.

Maybe this has to do with the FIFO behavior.  It would certainly
make sense to allow reads of any size from the FIFO.  If it were
raw reads on the data bus, then I'd expect that both 8 and 16 bit
widths would work.  (Assuming NAND chips weren't in parallel...)

If the FIFO is active, and specified to support arbitrary width
accesses (that don't match the data bus), then by all means use
the __raw_readsl() call to maximize bandwidth use.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
