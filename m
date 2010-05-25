From: Mickael Chazaux <mickael.chazaux@gmail.com>
Subject: [Regression] ads7846.c touchscreen controller driver reports wrong
	X,Y values
Date: Tue, 25 May 2010 17:54:50 +0200
Message-ID: <AANLkTinwrfeYybZysJ-hyZC4MCxjtAFSVos6ZOguZ9VE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:63684 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab0EYPyw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 11:54:52 -0400
Received: by ewy8 with SMTP id 8so586551ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 25 May 2010 08:54:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm@lists.arm.linux.org.uk

Hi,

I am working on adding the support of an omap3 based board in the
kernel. This board uses an ADS7843 touchscreen controller, on the SPI
bus. The in-kernel driver (drivers/input/touchscreen/ads7646.c) works
fine with the 2.6.33 kernel. When updating to the 2.6.34 kernel the
values reported by the driver were garbage. I had to revert this
commit [1] to make it work again. Can someone confirm that this driver
still works with other OMAP boards?

[1] a330ce2001b290c59fe98c37e981683ef0a75fdf

Regards,

Mickael

Adeneo Embedded - Adetel Group
2, chemin du Ruisseau
69134 ECULLY - FRANCE
T=C3=A9l. : +33 (0)4 72 18 08 40 - Fax : +33 (0)4 72 18 08 41
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
