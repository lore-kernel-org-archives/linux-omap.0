From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 19:32:42 +0300
Message-ID: <CAPo=G1xJj_mJAETqtxWdugYhP0LV=0XrMLeFGtkOBJZAi3Jy1A@mail.gmail.com>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk>
	<CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com>
	<20120427160445.GC28062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57440 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759702Ab2D0Qco convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 12:32:44 -0400
Received: by iadi9 with SMTP id i9so1894454iad.33
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 09:32:43 -0700 (PDT)
In-Reply-To: <20120427160445.GC28062@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

On Fri, Apr 27, 2012 at 7:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Right, so the only platform I have out of that (as I said above) is
> SDP4430.
>
> And as I've already said, it does *not* appear to support any audio
> of any kind:
>
> root@omap-4430sdp:~# insmod snd-soc-twl6040.ko
> root@omap-4430sdp:~# insmod snd-soc-omap.ko
> root@omap-4430sdp:~# insmod snd-soc-omap-mcpdm.ko
> root@omap-4430sdp:~# insmod snd-soc-omap-abe-twl6040.ko
> root@omap-4430sdp:~# cat /proc/asound/cards
> --- no soundcards ---

You need to load the DMIC driver as well:
insmod snd-soc-omap-dmic.ko

> So, it does *NOT* appear to support any kind of audio. =A0(If it does=
,
> software support for it is broken when built as modules.)

Audio should work as built in and as modules.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
