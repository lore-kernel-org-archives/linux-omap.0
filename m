From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Tue, 31 Jan 2012 23:40:33 +0200
Message-ID: <CANOLnOMzkNSr5hFbASCWaT6PkBSYQhqMxXmjBfU0tm0GTv=yYA@mail.gmail.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	<87obtlrniz.fsf@ti.com>
	<CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
	<87obtkpyna.fsf@ti.com>
	<alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
	<CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com>
	<alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com>
	<CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:44964 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752466Ab2AaVke convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 16:40:34 -0500
Received: by lbom4 with SMTP id m4so69767lbo.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 13:40:33 -0800 (PST)
In-Reply-To: <CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Tue, Jan 31, 2012 at 1:39 PM, Grazvydas Ignotas <notasas@gmail.com> =
wrote:
> So when does all wakeup stuff come into effect, when CORE+PER go to
> low power state? I'm using 3.2 and CORE seems to always be ON
> (regardless of cpuidle option) except when I suspend I guess. I can
> get PER state to change if I set serial timeouts, but that doesn't
> help the GPIO problem.

There is a strange thing in pm34xx.c, omap_sram_idle() function:
I've added logging of per_next_state, and it's always 1
(PWRDM_POWER_RET) for me, however if I check /debug/pm_debug/count ,
core_pwrdm and per_pwrdm only has 1 for ON and zeros for all other
states. That function calls gpio debounce clock disable if
per_next_state < PWRDM_POWER_ON.

Does that mean this code is preparing for RET but never enters it?
Maybe GPIO module ends up active but with debounce clock disabled?


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
