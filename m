From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 18:19:33 +0100
Message-ID: <20120427171933.GE28062@n2100.arm.linux.org.uk>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk> <CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com> <20120427160445.GC28062@n2100.arm.linux.org.uk> <CAPo=G1xJj_mJAETqtxWdugYhP0LV=0XrMLeFGtkOBJZAi3Jy1A@mail.gmail.com> <20120427165032.GD28062@n2100.arm.linux.org.uk> <CAPo=G1yiX1644Cwkdnt7Ff7+yYbJQw5mnEbwd0txw-Wj_YdV7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59898 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760562Ab2D0RTm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 13:19:42 -0400
Content-Disposition: inline
In-Reply-To: <CAPo=G1yiX1644Cwkdnt7Ff7+yYbJQw5mnEbwd0txw-Wj_YdV7Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

On Fri, Apr 27, 2012 at 08:04:52PM +0300, Ujfalusi, Peter wrote:
> On Fri, Apr 27, 2012 at 7:50 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> You need to load the DMIC driver as well:
> >> insmod snd-soc-omap-dmic.ko
> >
> > You must be joking...
>
> Well SDP4430/Blaze have the following setup:
> twl6040 via McPDM
> digital microphones via DMIC
>
> So I would:
> root@omap-4430sdp:~# insmod snd-soc-twl6040.ko
> root@omap-4430sdp:~# insmod snd-soc-omap.ko
> root@omap-4430sdp:~# insmod snd-soc-omap-mcpdm.ko
> root@omap-4430sdp:~# insmod snd-soc-omap-dmic.ko
> root@omap-4430sdp:~# insmod snd-soc-dmic.ko
> root@omap-4430sdp:~# insmod snd-soc-omap-abe-twl6040.ko
>
> Does this works for you?

root@omap-4430sdp:~# lsmod
Module                  Size  Used by
snd_soc_dmic            1492  0
snd_soc_omap4_hdmi      1724  0
snd_soc_omap_hdmi       1536  0
snd_soc_omap_abe_twl6040     4867  0
snd_soc_omap_dmic       4248  0
snd_soc_omap_mcpdm      3077  1 snd_soc_omap_abe_twl6040
snd_soc_omap            2987  0
snd_soc_twl6040        18601  1 snd_soc_omap_abe_twl6040
root@omap-4430sdp:~# cat /proc/asound/cards
--- no soundcards ---
root@omap-4430sdp:~# grep . /sys/kernel/debug/asoc/*
/sys/kernel/debug/asoc/codecs:dmic-codec
/sys/kernel/debug/asoc/codecs:snd-soc-dummy
/sys/kernel/debug/asoc/codecs:omapdss_hdmi
/sys/kernel/debug/asoc/dais:dmic-hifi
/sys/kernel/debug/asoc/dais:omap-dmic
/sys/kernel/debug/asoc/dais:omap-mcpdm
/sys/kernel/debug/asoc/dais:snd-soc-dummy-dai
/sys/kernel/debug/asoc/dais:hdmi-audio-codec
/sys/kernel/debug/asoc/platforms:omap-pcm-audio
/sys/kernel/debug/asoc/platforms:snd-soc-dummy

So the answer is... no.

> Or
> make modules_install
> depmod -a
> modprobe snd-soc-omap-abe-twl6040

That's not going to help one bit, as the only two modules that
snd-soc-omap-abe-twl6040 depends on are snd-soc-omap-mcpdm and
snd-soc-twl6040.
