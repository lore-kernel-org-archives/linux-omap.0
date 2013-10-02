From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 3/3] dma: cppi41: move -EAGAIN in tear_down
Date: Wed, 02 Oct 2013 13:38:46 +0200
Message-ID: <524C05C6.3090808@gmail.com>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com> <1380634271-27588-4-git-send-email-zonque@gmail.com> <20131002082914.GA16680@linutronix.de> <524BE518.8060008@gmail.com> <524BF487.20105@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:56124 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab3JBLiu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 07:38:50 -0400
In-Reply-To: <524BF487.20105@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On 02.10.2013 12:25, Sebastian Andrzej Siewior wrote:
> On 10/02/2013 11:19 AM, Daniel Mack wrote:

>> Once the system is booted up and the USB media is detected, I send t=
he
>> system to sleep mode with "cat mem >/sys/power/state". After wakeup,=
 I
>> access the media by mounting and unmounting it once, then send the
>> system back to sleep.
>=20
> Okay. Going to sleep is probably easy, I need to figure out how to
> wakeup=E2=80=A6

Unless you pass no_console_suspend in your cmdline, you can just wake u=
p
the system via UART0. IOW, just press enter on the serial console.


Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
