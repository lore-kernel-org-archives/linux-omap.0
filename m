From: Grazvydas Ignotas <notasas@gmail.com>
Subject: GPIO debounce problems on 3.2
Date: Fri, 27 Jan 2012 00:57:48 +0200
Message-ID: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44309 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752178Ab2AZW5u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jan 2012 17:57:50 -0500
Received: by lagu2 with SMTP id u2so632188lag.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Jan 2012 14:57:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On 3.2 (I think some earlier versions too), with CONFIG_CPU_IDLE
enabled GPIO based buttons are not working properly on OMAP3 pandora,
button presses are almost never registered. The buttons are connected
GPIO bank4 and have hardware debounce feature enabled.

Doing either of the following solves (or hides) the problem:
- disabling CPU_IDLE in kernel config
- disabling debounce for the buttons
- running a program spinning a loop on the CPU

=46rom what I can see in the code debounce clock is disabled when
entering idle, can those GPIOs work without debounce clock?


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
