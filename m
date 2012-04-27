From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 21:14:23 +0300
Message-ID: <CAPo=G1wDANyQ5ARyerizp6oA=Wyc7s_to7zfz-n4GdZ20tfX4g@mail.gmail.com>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk>
	<CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com>
	<20120427160445.GC28062@n2100.arm.linux.org.uk>
	<CAPo=G1xJj_mJAETqtxWdugYhP0LV=0XrMLeFGtkOBJZAi3Jy1A@mail.gmail.com>
	<20120427165032.GD28062@n2100.arm.linux.org.uk>
	<CAPo=G1yiX1644Cwkdnt7Ff7+yYbJQw5mnEbwd0txw-Wj_YdV7Q@mail.gmail.com>
	<20120427171933.GE28062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:39555 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760977Ab2D0SO3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 14:14:29 -0400
Received: by yenl11 with SMTP id l11so744642yen.30
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 11:14:24 -0700 (PDT)
In-Reply-To: <20120427171933.GE28062@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

On Fri, Apr 27, 2012 at 8:19 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> root@omap-4430sdp:~# lsmod
> Module =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used by
> snd_soc_dmic =A0 =A0 =A0 =A0 =A0 =A01492 =A00
> snd_soc_omap4_hdmi =A0 =A0 =A01724 =A00
> snd_soc_omap_hdmi =A0 =A0 =A0 1536 =A00
> snd_soc_omap_abe_twl6040 =A0 =A0 4867 =A00
> snd_soc_omap_dmic =A0 =A0 =A0 4248 =A00
> snd_soc_omap_mcpdm =A0 =A0 =A03077 =A01 snd_soc_omap_abe_twl6040
> snd_soc_omap =A0 =A0 =A0 =A0 =A0 =A02987 =A00
> snd_soc_twl6040 =A0 =A0 =A0 =A018601 =A01 snd_soc_omap_abe_twl6040
> root@omap-4430sdp:~# cat /proc/asound/cards
> --- no soundcards ---
> root@omap-4430sdp:~# grep . /sys/kernel/debug/asoc/*
> /sys/kernel/debug/asoc/codecs:dmic-codec
> /sys/kernel/debug/asoc/codecs:snd-soc-dummy
> /sys/kernel/debug/asoc/codecs:omapdss_hdmi

the twl6040 codec is missing.

> /sys/kernel/debug/asoc/dais:dmic-hifi
> /sys/kernel/debug/asoc/dais:omap-dmic
> /sys/kernel/debug/asoc/dais:omap-mcpdm
> /sys/kernel/debug/asoc/dais:snd-soc-dummy-dai
> /sys/kernel/debug/asoc/dais:hdmi-audio-codec

as well the dai for the twl6040.

> /sys/kernel/debug/asoc/platforms:omap-pcm-audio
> /sys/kernel/debug/asoc/platforms:snd-soc-dummy
>
> So the answer is... no.

Hrm.
I don't think you can build the twl6040 MFD core driver as a module.
Do you have CONFIG_TWL6040_CORE=3Dy ?
We have MFD for twl6040 since it provides audio and vibra functionality=
 as well.

Can you check if you have this commit:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dcomm=
it;h=3D8eaeb9393397be8eb700ab38a69c450975463b77

This is the second patch to separate the twl6040 from twl-core.
If you are missing this patch twl6040 will not probe (twl core will
not register the
audio if we have twl6030).

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
