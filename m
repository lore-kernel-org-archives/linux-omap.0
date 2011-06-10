From: =?iso-8859-1?q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: HELP:How to power down TWL5030 Voice/Bluetooth sidetone PGA?
Date: Fri, 10 Jun 2011 17:16:13 +0300
Message-ID: <201106101716.14008.peter.ujfalusi@ti.com>
References: <BANLkTik0mX5wSYNdBwhjxuaKa6908fmazQ@mail.gmail.com> <201106101048.45966.peter.ujfalusi@ti.com> <BANLkTi=9sg-WL+OXeA4J9rcH7c6zg+R3Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60611 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755708Ab1FJOQR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jun 2011 10:16:17 -0400
In-Reply-To: <BANLkTi=9sg-WL+OXeA4J9rcH7c6zg+R3Pw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: onlyfever <onlyfever@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

> 2011/6/10 P=E9ter Ujfalusi <peter.ujfalusi@ti.com>:
> 1. when use Headset:
> uplink routing:HSMIC --> AVTXR2PGA & AVTXL2PGA --> VDXS & VDXM --> PC=
M_VDX
> downlink routing:PCM_VDR --> VDR -->  VRXPGA Fine gain --> DAC voice
> --> VDL_GAIN Analog PGA --> HSOL/HSOR

Thanks
=20
> I check the loopbacks,it seems that all Loopbacks have been disabled.
> bash-3.2# alsa_amixer |grep Loopback
> Simple mixer control 'Left Digital Loopback',0
> Simple mixer control 'Left1 Analog Loopback',0
> Simple mixer control 'Left2 Analog Loopback',0
> Simple mixer control 'Right Digital Loopback',0
> Simple mixer control 'Right1 Analog Loopback',0
> Simple mixer control 'Right2 Analog Loopback',0
> Simple mixer control 'Voice Analog Loopback',0
> Simple mixer control 'Voice Digital Loopback',0

Can you check with:
amixer | grep -A 6  Loopback


> The sidetone is become louder if I increase the VSTPGA,
> and when I increase the VDL_GAIN Analog PGA,the sidetone is become lo=
uder
> too. But the VRXPGA seems don't affect the sidetone,so I think VSTPGA
> cause the sidetone.
>=20
> 2.when use Bluetooth:
> uplink routing:BT_PCM_VDR --> BTTXPGA --> VDXM --> PCM_VDX
> downlink routing:PCM_VDR --> VDR --> BTRXPGA --> BT_PCM_VDX
>=20
> When use Bluetooth interface,I don't know if something else can cause
> sidetone except BTSTPGA.

I don't have a board, which have this feature, but I'll check the TRM a=
nd the=20
code, if I can find something. Probably worth to find the ERRATA docume=
nt as=20
well...

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
