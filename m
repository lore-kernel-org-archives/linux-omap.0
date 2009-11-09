From: John Faith <jfaith7@gmail.com>
Subject: GPIO IRQ handler called only once
Date: Mon, 9 Nov 2009 15:27:17 -0800
Message-ID: <e0727e900911091527k666a6079g652f829948e594d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:39389 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbZKIX1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 18:27:12 -0500
Received: by iwn10 with SMTP id 10so2819721iwn.4
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2009 15:27:18 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
I'm using a 2.6.29rc3 kernel on a custom omap3530 board.  In my
board.c file I configure gpio_10 as an interrupt line, in the driver I
set flags for a falling edge, and when the hardware drops the line
low, I do get the irq handler called in my driver and the entry in
/proc/interrupts is updated from zero to one.  The interrupt handler
does nothing but return IRQ_HANDLED.

A second interrupt from the attached peripheral does not seem to
trigger the handler, though.  Prototype hardware may be causing this,
but is there anything in the gpio/irq infrastructure which requires
that state be cleared other than returning IRQ_HANDLED?

Thanks!
,
John
