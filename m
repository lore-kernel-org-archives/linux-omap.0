From: Phaneendra Kumar Alapati <phani@embwise.com>
Subject: Re: [PATCH] OMAP35xx: Added SDIO IRQ support
Date: Thu, 29 Oct 2009 20:05:42 +0530
Message-ID: <54d94f230910290735v3dc5a82pee90b4a73d152964@mail.gmail.com>
References: <54d94f230910280618l1b770505lfc88af7592777763@mail.gmail.com>
	<000001ca57e8$e4108ec0$544ff780@am.dhcp.ti.com> <4AE89FEC.9000309@googlemail.com>
	<4AE93D91.4020300@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail10.myhsphere.biz ([64.71.235.184]:55376 "EHLO
	mail10.myhsphere.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323AbZJ2OgC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 10:36:02 -0400
Received: by pxi9 with SMTP id 9so1208234pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 07:36:02 -0700 (PDT)
In-Reply-To: <4AE93D91.4020300@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Madhusudhan <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Steve Sakoman <sakoman@gmail.com>

On Thu, Oct 29, 2009 at 12:30 PM, Dirk Behme <dirk.behme@googlemail.com=
> wrote:
> Dirk Behme wrote:
>
> I promised to come back with test results. As mentioned in this threa=
d
> already, I can't test on my own yet, instead Steve (many, many thanks=
!)
> tests it on Overo air. Overo air uses Marvell's 88W8686 connected to =
MMC
> port 2 in 4 bit configuration.
>
> First, my 'revised' version of Phani's patch doesn't work at all. The=
re seem
> to be some tricks in Phani's original patch we (I?) missed in above r=
eview.
> I tried to incorporate all review comments, result is a non working p=
atch.
>

As i mentioned earlier, the code changes you made will result in loss
of sdio interrupts which will effect the host driver functionality.

> Second, Steve tested Phani's original patch, too (with manually fixed
> wrapped lines). Let me copy his comments:
>
> -- cut --
> this is looking better!
>
> libertas_sdio: Libertas SDIO driver
> libertas_sdio: Copyright Pierre Ossman
> libertas_sdio mmc1:0001:1: firmware: requesting sd8686_helper.bin
> libertas_sdio mmc1:0001:1: firmware: requesting sd8686.bin
> libertas: 00:19:88:20:fa:23, fw 9.70.3p24, cap 0x00000303
> libertas: eth1: Marvell WLAN 802.11 adapter
> udev: renamed network interface eth1 to wlan0
>
> (with the other patches we always had timeouts and errors)
>
> But performance is really bad (and flakey!)
>
> When it does work, I get 5.88K/s as compared to 120K/s with the unpat=
ched
> code. =A0It also dies fairly quickly.
>
> No error messages, so I am really not sure what is going on!
> -- cut --

Iam not sure about what might be causing such a drastically low
performance with steve's testing. The initial SDIO interrupts occur
once the firmware gets loaded properly. From the log it looks the
firmware is loading successfully and interface is up. In which case it
means the interrupt mechanism is proper as it should be. So the
reduction in performance cant be that worse when handling SDIO
interrupts with irq support. Even with the SDIO interrupt mechanism in
 polling mode i observed throughput in the range of 1 to 2 Mbps.

Given below are details of my test environment:
Target boards: OMAP3530EVM and AM3517EVM
Linux kernel version: 2.6.31-rc7.
The host operating frequency is 25MHz and in sdio 4bit mode of operatio=
n.
Libertas firmware<9.70.3.p24-26409.P45-GPL> from marvell
<http://www.marvell.com/drivers/driverDisplay.do?driverId=3D203>

Mode: Infrastructure mode
Channel 11
Phy Mode:  G

Observed throughput [using ttcp utility]: 13Mbps (Downlink), 10.5 Mbps(=
Uplink)

The throughput measurements are taken with Marvell 88W8686 card on one
end connected to an access point and on the other end the access point
connected to a test system through ethernet. The WiFi performance
would enhance under proper test conditions.

Regards,
Phani

> Any ideas?
>
> Thanks to Phani and Steve, best regards
>
> Dirk
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
