From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 17:04:45 +0100
Message-ID: <20120427160445.GC28062@n2100.arm.linux.org.uk>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk> <CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36363 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab2D0QEy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 12:04:54 -0400
Content-Disposition: inline
In-Reply-To: <CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Fri, Apr 27, 2012 at 06:53:39PM +0300, Ujfalusi, Peter wrote:
> Hi Russell,
>=20
> On Fri, Apr 27, 2012 at 4:58 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Can someone please hint on what audio is supported on these two OMA=
P
> > boards? =A0From what I can tell, the answer is either "nothing" or =
"hdmi",
> > both of which are useless to me if someone wants me to convert the =
OMAP
> > ASoC driver to DMA engine.
> >
> > From what I can see on the 4430SDP, there's a 3.5mm headset jack,
> > microphones and speakers on the board, so the board does have audio
> > hardware. =A0However, it seems (as, I'm afraid to say, seems to be =
pretty
> > much standard practice with OMAP) there's a total lack of software
> > support in mainline.
>=20
> 3.4-rc have audio support for SDP4430/Blaze, PandaBoard4430,
> PandaBoardES (4460).
> OMAP3 support is there for a long time, not sure about 3430LDP, but
> the omap3-SDP,
> BeagleBoards, Nokia n900, Pandora have at least ASoC machine driver.

Right, so the only platform I have out of that (as I said above) is
SDP4430.

And as I've already said, it does *not* appear to support any audio
of any kind:

root@omap-4430sdp:~# insmod snd-soc-twl6040.ko                         =
        =20
root@omap-4430sdp:~# insmod snd-soc-omap.ko                            =
        =20
root@omap-4430sdp:~# insmod snd-soc-omap-mcpdm.ko                      =
        =20
root@omap-4430sdp:~# insmod snd-soc-omap-abe-twl6040.ko                =
        =20
root@omap-4430sdp:~# cat /proc/asound/cards                            =
        =20
--- no soundcards ---                                                  =
        =20

and that's with HDMI audio via DSS enabled.

So, it does *NOT* appear to support any kind of audio.  (If it does,
software support for it is broken when built as modules.)

How do I get audio support working on this platform?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
