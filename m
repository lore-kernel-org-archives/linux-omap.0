From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 20:04:52 +0300
Message-ID: <CAPo=G1yiX1644Cwkdnt7Ff7+yYbJQw5mnEbwd0txw-Wj_YdV7Q@mail.gmail.com>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk>
	<CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com>
	<20120427160445.GC28062@n2100.arm.linux.org.uk>
	<CAPo=G1xJj_mJAETqtxWdugYhP0LV=0XrMLeFGtkOBJZAi3Jy1A@mail.gmail.com>
	<20120427165032.GD28062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:51352 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757446Ab2D0REy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 13:04:54 -0400
Received: by iakk32 with SMTP id k32so1569690iak.34
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 10:04:52 -0700 (PDT)
In-Reply-To: <20120427165032.GD28062@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

On Fri, Apr 27, 2012 at 7:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> You need to load the DMIC driver as well:
>> insmod snd-soc-omap-dmic.ko
>
> You must be joking...

Well SDP4430/Blaze have the following setup:
twl6040 via McPDM
digital microphones via DMIC

So I would:
root@omap-4430sdp:~# insmod snd-soc-twl6040.ko
root@omap-4430sdp:~# insmod snd-soc-omap.ko
root@omap-4430sdp:~# insmod snd-soc-omap-mcpdm.ko
root@omap-4430sdp:~# insmod snd-soc-omap-dmic.ko
root@omap-4430sdp:~# insmod snd-soc-dmic.ko
root@omap-4430sdp:~# insmod snd-soc-omap-abe-twl6040.ko

Does this works for you?

Or
make modules_install
depmod -a
modprobe snd-soc-omap-abe-twl6040

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
