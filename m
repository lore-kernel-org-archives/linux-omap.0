From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB-ehci enumeration issue
Date: Mon, 2 May 2011 12:56:48 +0300
Message-ID: <20110502095647.GU2529@legolas.emea.dhcp.ti.com>
References: <BANLkTin1WEd0KeUb7kZ80GAYbEQC3SkezA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59363 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756858Ab1EBJ4x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 05:56:53 -0400
Received: by mail-fx0-f52.google.com with SMTP id 6so6124979fxm.39
        for <linux-omap@vger.kernel.org>; Mon, 02 May 2011 02:56:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTin1WEd0KeUb7kZ80GAYbEQC3SkezA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org

Hi,

On Fri, Apr 15, 2011 at 05:44:44PM +0530, ABRAHAM, KISHON VIJAY wrote:
> Hi,
> 
> I tried to test ehci based in 2.6.39 rc2 + reverts commit
> 09173b589d547c002b6a2b560e150c4d7bb56c99.
> 
> I connected a HS device to HS-USB1 and find it's trying to enumerate the
> device as FS and fails.
> 
> / # [   25.171356] usb usb1: usb wakeup-resume
> [   25.175689] usb usb1: usb auto-resume
> [   25.179565] ehci-omap ehci-omap.0: resume root hub
> [   25.226654] hub 1-0:1.0: hub_resume
> [   25.230346] ehci-omap ehci-omap.0: GetStatus port:1 status 001803 0  ACK
> POWER sig=j CSC CONNECT
> [   25.239654] hub 1-0:1.0: port 1: status 0501 change 0001
> [   25.351806] hub 1-0:1.0: state 7 ports 3 chg 0002 evt 0000
> [   25.357604] hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
> [   25.421966] ehci-omap ehci-omap.0: port 1 full speed --> companion
> [   25.428436] ehci-omap ehci-omap.0: GetStatus port:1 status 003801 0  ACK
> POWER OWNER sig=j CONNECT
> [   25.437866] hub 1-0:1.0: port 1 not reset yet, waiting 50ms
> [   25.500030] ehci-omap ehci-omap.0: GetStatus port:1 status 003002 0  ACK
> POWER OWNER sig=se0 CSC
> [   25.509399] hub 1-0:1.0: unable to enumerate USB device on port 1
> [   25.515838] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0002
> [   27.976806] hub 1-0:1.0: hub_suspend
> [   27.980590] usb usb1: bus auto-suspend
> [   27.984527] ehci-omap ehci-omap.0: suspend root hub
> 
> Does anyone else observe this issue?

could be the regulators problem. Can you try with my hci branch ?

git://gitorious.org/usb/usb.git hci

-- 
balbi
