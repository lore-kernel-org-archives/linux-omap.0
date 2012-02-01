From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Wed, 1 Feb 2012 13:46:46 +0200
Message-ID: <CANOLnOMmcztNH+fUzrQxjK5nVVEaAtLi=7ww+dPm0AXEv09qUA@mail.gmail.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	<87obtlrniz.fsf@ti.com>
	<CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
	<87obtkpyna.fsf@ti.com>
	<alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
	<CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com>
	<alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com>
	<CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com>
	<CANOLnOMzkNSr5hFbASCWaT6PkBSYQhqMxXmjBfU0tm0GTv=yYA@mail.gmail.com>
	<alpine.DEB.2.00.1201312254150.10061@utopia.booyaka.com>
	<alpine.DEB.2.00.1201312305190.10061@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35705 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753786Ab2BALqs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Feb 2012 06:46:48 -0500
Received: by lagu2 with SMTP id u2so595583lag.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 03:46:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201312305190.10061@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Wed, Feb 1, 2012 at 8:06 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 31 Jan 2012, Paul Walmsley wrote:
>
>> Well, whether it's in or out of idle, I'll bet the DEBOUNCENABLE
>> bits are still set to 1 while the debounce clock is off :-(
>
> Along these lines, you might try patching omap2_gpio_prepare_for_idle=
() to
> turn off the DEBOUNCENABLE bits?

Yes that helps. I guess I'll carry this in pandora tree, at least
we'll have debounce while more demanding programs/games are running.
Don't know how it's all working for Kevin though..


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
