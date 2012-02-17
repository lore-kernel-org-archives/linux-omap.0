From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: help: BeagleBoard xM RevC ethernet port
Date: Fri, 17 Feb 2012 10:24:23 +0200
Message-ID: <4F3E0EB7.9060803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50314 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752016Ab2BQIY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 03:24:27 -0500
Received: by mail-lpp01m010-f51.google.com with SMTP id s15so3491211lag.38
        for <linux-omap@vger.kernel.org>; Fri, 17 Feb 2012 00:24:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: balbi@ti.com

Hi,

I hoped that time will solve this, but so far no luck. I just can not
get the ethernet port (along with the USB host ports) working on my xM =
RevC.
What is the trick to get it working on 3.3-rc3?

There seams to be some configuration issue:

[    1.437530] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    1.444671] ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 96
[    1.451354] ehci-omap ehci-omap.0: failed to get ehci port0 regulato=
r
[    1.458282] ehci-omap ehci-omap.0: failed to get ehci port1 regulato=
r
[    2.465850] ehci-omap ehci-omap.0: phy reset operation timed out
[    3.473663] ehci-omap ehci-omap.0: phy reset operation timed out
[    3.479980] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=3D0 c=
c=3D1
pcc=3D3 ordered ports=3D3
[    3.488769] ehci-omap ehci-omap.0: reset hcc_params 0016 thresh 1
uframes 256/512/1024 park
[    3.497589] ehci-omap ehci-omap.0: reset command 0080b02  park=3D3
ithresh=3D8 period=3D1024 Reset HALT
[    3.506927] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller

gentoo ~ # lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

So only the root hub is working, the LAN9514 does not.
Yes, I have enabled the needed configs in my kernel.

Can someone send me a config file for 3.3-rc3 with working ethernet por=
t?

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
