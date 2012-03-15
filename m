From: Kevin Hilman <khilman@ti.com>
Subject: Re: GPIO abort on 3630/Zoom3
Date: Thu, 15 Mar 2012 10:37:21 -0700
Message-ID: <87k42lbwa6.fsf@ti.com>
References: <87d38eet48.fsf@ti.com>
	<CAC83ZvLMWxxr7QSca0a9+wJR_gJ6-s6ddfUQdVqQ-XbWSoNa+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:50130 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030464Ab2CORhL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 13:37:11 -0400
Received: by mail-pz0-f42.google.com with SMTP id g27so5087684dan.15
        for <linux-omap@vger.kernel.org>; Thu, 15 Mar 2012 10:37:07 -0700 (PDT)
In-Reply-To: <CAC83ZvLMWxxr7QSca0a9+wJR_gJ6-s6ddfUQdVqQ-XbWSoNa+w@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Thu, 15 Mar 2012 08:43:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Thu, Mar 15, 2012 at 3:35 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun,
>>
>> Can you investigate an abort during boot on 3630/Zoom3?
>>
>> Both Tony and I are seeing the abort below on 3630/Zoom3. =C2=A0I'm =
using
>> arm-soc/for-next and Tony is using linux-next, but we see the same a=
bort.
> The crash looks very similar to what we fixed yesterday. The problem =
was
> basically due to usage of OMAP_GPIO_IRQ macro instead of gpio_to_irq(=
)
> which came as part of Benoit's dynamic irq allocation change. The fix=
 is to
> replace those macros in the board files.
> (The same problem is seen on OMAP3430 SDP as well.)
> Anyways, I will confirm.
>
>>
>> Adding in your latest fixes series doesn't make the problem go away,=
 but
>> backing out the GPIO runtime PM series does make the problem go away=
=2E
> Because of dynamic irq allocation we end up into wrong GPIO Bank unle=
ss
> we use the new gpio_to_irq(). As a result _set_gpio_triggering() trie=
s
> to operate
> on a GPIO Bank whose clock was not turned on using omap_gpio_request(=
).
> Probably, that is why we do not see the problem when the runtime PM s=
eries
> is removed because in this case all the GPIO banks are turned on.

Yeah, this sounds like the same bug.  Thanks for investigating.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
