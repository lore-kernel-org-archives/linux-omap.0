From: David Brownell <david-b@pacbell.net>
Subject: Re: What happened to the serial console on BeagleBoard with 2.6.28-rc2?
Date: Sun, 2 Nov 2008 09:03:42 -0700
Message-ID: <200811020803.42834.david-b@pacbell.net>
References: <E1KwOu8-0005NM-LE@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:44733 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753610AbYKBQDp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Nov 2008 11:03:45 -0500
In-Reply-To: <E1KwOu8-0005NM-LE@amazonia.comcast.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rick@efn.org
Cc: linux-omap@vger.kernel.org, nmonson@gmail.com

On Saturday 01 November 2008, Rick Bronson wrote:
> @@ -155,7 +155,7 @@ static struct map_desc omap34xx_io_desc[
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.virtual=A0=A0=A0=A0=A0=
=A0=A0=A0=3D L4_PER_34XX_VIRT,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.pfn=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=3D __phys_to_pfn(L4_PER_34XX_PHYS),
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.length=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=3D L4_PER_34XX_SIZE,
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.type=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=3D MT_DEVICE
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.type=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=3D MT_MEMORY_SO =A0/* debug only */
> =A0=A0=A0=A0=A0=A0=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.virtual=A0=A0=A0=A0=A0=
=A0=A0=A0=3D L4_EMU_34XX_VIRT,

Leaving only one map_desc[] entry left using MT_DEVICE not MT_MEMORY_SO=
=2E..
I didn't try this, since I'm currently not hooking up that serial port,
but dmesg does show(*):

 Serial: 8250/16550 driver3 ports, IRQ sharing disabled
 serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
 serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
 serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16650V2
 console [ttyS2] enabled

Is that what you saw too?

- Dave

(*) Only the third port ("ttyS2") is physically wired of course...
    the second could be, but isn't.
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
