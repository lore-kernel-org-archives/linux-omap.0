From: "Ramesh Gupta Guntha" <x0023949@ti.com>
Subject: RE: Question about timers used in dsp bridge
Date: Tue, 16 Sep 2008 16:10:53 +0530
Message-ID: <200809161040.m8GAesjU011517@dbdp31.itg.ti.com>
References: <87myi8wfdw.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36839 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbYIPKlL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2008 06:41:11 -0400
In-Reply-To: <87myi8wfdw.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?'=22H=F6gander=22_Jouni'?= <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

Hi Jouni,=20

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of=20
> "H=F6gander" Jouni
> Sent: Tuesday, September 16, 2008 4:02 PM
> To: linux-omap@vger.kernel.org
> Subject: Question about timers used in dsp bridge
>=20
> Hi,
>=20
> Dsp bridge is using gpt5 and gpt6. When loading baseimage:
>=20
> cexec.out -T /lib/dsp/baseimage.dof
>=20
> both timers are started, but gpt5 is stopped at some point. Gpt6 is
> left running. Any idea what for these timers are used and why gpt6 is
> left running?

In Dsp Bridge GPT5 is used as BIOS_CLK and used only while DSP is start=
ing, this is disabled once the DSP is started.=20
GPT6 is used for load monitoring purpose by DSP Bridge. GPT6 is disable=
d only if the DSP enters into sleep state i.e. Hibernation.

Thanks
Ramesh Gupta G


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
