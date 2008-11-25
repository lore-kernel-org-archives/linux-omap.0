From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 18:59:45 +0200
Message-ID: <6ed0b2680811250859x179afb67l5cca390d3b1e4de1@mail.gmail.com>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:38425 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbYKYQ75 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 11:59:57 -0500
Received: by gxk9 with SMTP id 9so76722gxk.8
        for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 08:59:46 -0800 (PST)
In-Reply-To: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hi,

TWL4030 and compatibles have 2 pulse-width modulation (PWM) generators
(PWM0 and PWM1). They are used for backlight control and charger LED
in pandora board. I wasn't able to find any drivers for them in
linux-omap tree. Is there anyone working on these? If not, what would
be the proper way to expose them? May be as LED driver?
I saw lcd_omap*evm.c just write to LED PWM registers over i2c to
control backlight, I wonder if I should just do the same.

Gra=9Evydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
