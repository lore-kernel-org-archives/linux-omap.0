From: Andrew Tverdohlebov <fat031c@gmail.com>
Subject: Re: small question about gpio and interrupts
Date: Fri, 16 Apr 2010 14:23:36 +1100
Message-ID: <n2yf7b83a9f1004152023m6bb44c68m362ec1d704e62410@mail.gmail.com>
References: <s2kf7b83a9f1004152015j351a3c28v3179b64e9e51e9df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59687 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757625Ab0DPDXh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 23:23:37 -0400
Received: by gwaa18 with SMTP id a18so1126876gwa.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 20:23:36 -0700 (PDT)
In-Reply-To: <s2kf7b83a9f1004152015j351a3c28v3179b64e9e51e9df@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear linux-omap community,

I am writing a simple driver for BeagleBoard and trying to get an
understanding of how interrupts work.
Could you please answer a small question.
What is a difference between irq and virtual_irq_start in structure
gpio_bank in file arch/arm/plat-omap/gpio.c

As far as I understood irq corresponds to real hardware interrupts
while=A0virtual_irq_start is completely obscure for me.
I didn't find a clue in the documentation.

Any tiny help will be hugely appreciated.
 Andrew
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
