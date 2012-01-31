From: Paul Walmsley <paul@pwsan.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Mon, 30 Jan 2012 23:13:43 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201302310120.10061@utopia.booyaka.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com> <87obtlrniz.fsf@ti.com> <CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com> <87obtkpyna.fsf@ti.com> <alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2066120892-1327990423=:10061"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39888 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab2AaGNo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 01:13:44 -0500
In-Reply-To: <alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2066120892-1327990423=:10061
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 30 Jan 2012, Paul Walmsley wrote:

> It seems highly suspicious to me that nothing in=20
> set_24xx_gpio_triggering() in our GPIO code seems to touch the=20
> WAKEUPENABLE register.

Heh.  Just wanted to follow up on this for anyone who cares.  Gra=B8vydas=
=20
noticed that the bit was indeed being set, so was curious to find out why. =
=20
It turns out that, like some other GPIO regs, there is another pair of=20
registers that can be used to modify the wakeup state without a=20
read-modify-write cycle, and the GPIO driver uses these other two regs -=20
GPIO_SETWKUENA and GPIO_CLEARWKUENA.

=20
 - Paul
--155748971-2066120892-1327990423=:10061--
