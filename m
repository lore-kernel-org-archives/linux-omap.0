From: "Jerry Johns" <Jerry.Johns@nuvation.com>
Subject: OMAP3 <-> FPGA boot-delay
Date: Mon, 19 Oct 2009 13:44:12 -0700
Message-ID: <274F7B50569A1B4C9D7BCAB17A9C7BE101D00272@mailguy3.skynet.nuvation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.nuvation.com ([68.65.78.147]:13988 "EHLO
	mailguy3.skynet.nuvation.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757411AbZJSUoI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Oct 2009 16:44:08 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello all,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I'm not exactly sure where to ask thi=
s, but I figured it would be on a mailing list that is linux specific, =
with a slight bias towards the OMAP:

I have an OMAP3530 mated to an FPGA over the GPMC interface found on th=
at chip. I have an interrupt controller on the FPGA (and mapped into vi=
rtual IRQs in Linux through irqchip and chained handlers) and a few UAR=
Ts in it as well - the UART is specifically chosen to be 16550 compatib=
le so that it can directly be mapped as a platform device into the 8250=
 serial platform driver. This way, I avoid having to write a serial dri=
ver, and it is directly compatible with that in Linux.

The FPGA currently is programmed by a separate device on boot, and that=
 process can take up to 20 seconds - hence, the interrupt layer and ser=
ial driver in Linux cannot really be loaded until the FPGA has complete=
d boot. At the same time, I do not want to hold-off booting Linux till =
the FPGA is alive.

What is the correct solution to this? Should I just load the interrupt =
and serial drivers anyways (and not use them till the FPGA is up) or sh=
ould I defer loading them? If the latter is a better idea, how do I do =
a deferred hotplug-style serial device connection? Can platform_device_=
register happen much later in the boot lifecycle?

Any ideas are much appreciated!

Thanks,
Jerry Johns
Design Engineer
Nuvation Research Corp - Canada
Tel: (519) 746-2304 ext. 221
www.nuvation.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
