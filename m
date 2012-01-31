From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Tue, 31 Jan 2012 13:39:05 +0200
Message-ID: <CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	<87obtlrniz.fsf@ti.com>
	<CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
	<87obtkpyna.fsf@ti.com>
	<alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
	<CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com>
	<alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57257 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752949Ab2AaLjG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 06:39:06 -0500
Received: by lagu2 with SMTP id u2so2797192lag.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 03:39:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Tue, Jan 31, 2012 at 3:48 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> If the DEBOUNCENABLE bit is set and the debounce clock is off and the=
 GPIO
> IP block is idle, then yeah, I'd assume that GPIO wakeups would not
> work.
>
> But it sounds like they are working for you when DEBOUNCENABLE is set=
 and
> the debounce clock is on and the GPIO IP block is idle and CORE & PER=
 are
> ON?

I think so. It works with DEBOUNCENABLE set when cpuidle is disabled
or CPU is spinning. CORE & PER are ON according to pm_debug/count, I
think debounce clock is enabled too but I don't know if GPIO is idle
then (how do I check?).

> And when DEBOUNCENABLE is clear and the debounce clock is off and the=
 GPIO
> IP block is idle and CORE & PER are still ON, then they work?

Yes.

> If the answer to those two latter questions are true, then it sounds =
like
> the hardware is working more or less as expected...

So when does all wakeup stuff come into effect, when CORE+PER go to
low power state? I'm using 3.2 and CORE seems to always be ON
(regardless of cpuidle option) except when I suspend I guess. I can
get PER state to change if I set serial timeouts, but that doesn't
help the GPIO problem.

> Of course our software support probably still isn't right. =C2=A0We p=
robably
> should keep the debounce clock enabled as long as some GPIO has debou=
nce
> support enabled. =C2=A0And probably provide some way for GPIO users t=
o indicate
> whether they are okay with debounce support being disabled when the
> rest of the CORE/PER can enter a low-power state. =C2=A0The motivatin=
g
> principle being that PM shouldn't violate a requirement from the rest=
 of
> the system...
>
> Anyway, just thinking out loud.
>
>
> - Paul

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
