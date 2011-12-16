From: Grazvydas Ignotas <notasas@gmail.com>
Subject: problem with twl4030 GPIO irqs
Date: Fri, 16 Dec 2011 02:03:51 +0200
Message-ID: <CANOLnON1-vg45KWZ7Rp+jL1n-jwBiTA2Qmkr_z1XnDKQ0XBPJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46259 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab1LPADw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 19:03:52 -0500
Received: by eekc4 with SMTP id c4so2687329eek.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 16:03:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>, Felipe Balbi <balbi@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

I'm running 3.2-rc5 on pandora with Neil's twl patches on top, and
omap_hsmmc driver fails to probe:
[    3.491394] omap_hsmmc omap_hsmmc.0: context was not lost
[    3.497161] omap_hsmmc omap_hsmmc.0: enabled
[    3.715270] omap_hsmmc omap_hsmmc.0: Unable to grab MMC CD IRQ

Pandora is using twl4030 GPIOs for card detect. From what I tried to
debug, omap_hsmmc is failing after call to request_irq() on card
detect irq with -EINVAL, irq number is 384 which is in range of other
twl4030 irqs. It looks like request_irq() is calling
request_threaded_irq() on ARM with NULL thread_fn, which in turn calls
__setup_irq() that calls irq_settings_is_nested_thread() that results
with true. As this nested flag is set it checks thread_fn, but that is
NULL causing -EINVAL final result.

Could someone who knows irq code better look at this? I think this
should reproduce on beagle too.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
