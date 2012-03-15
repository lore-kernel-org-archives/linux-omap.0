From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: GPIO abort on 3630/Zoom3
Date: Thu, 15 Mar 2012 12:13:53 +0530
Message-ID: <CAMQu2gyc5Ng0KPJ6rSV5X+FPG5WuVw7s+B-XQko0C+6cBE+nCg@mail.gmail.com>
References: <87d38eet48.fsf@ti.com> <CAC83ZvLMWxxr7QSca0a9+wJR_gJ6-s6ddfUQdVqQ-XbWSoNa+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:49768 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753232Ab2COGoO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Mar 2012 02:44:14 -0400
Received: by yenq4 with SMTP id q4so3486508yen.35
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 23:44:13 -0700 (PDT)
In-Reply-To: <CAC83ZvLMWxxr7QSca0a9+wJR_gJ6-s6ddfUQdVqQ-XbWSoNa+w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Mar 15, 2012 at 8:43 AM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Thu, Mar 15, 2012 at 3:35 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun,
>>
>> Can you investigate an abort during boot on 3630/Zoom3?
>>
>> Both Tony and I are seeing the abort below on 3630/Zoom3. =A0I'm usi=
ng
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
>
To be clear, the issue which we saw was wiith Grant's tree which has
GPIO sparce IRQ conversion. So if the issue is seen with linux for-next=
,
it must be the same issue.

There are many board files which are still using static OMAP_GPIO_IRQ
macro to retrieve the IRQ number which won't work anymore after
the gpio sparce irq conversion series. We will post a patch against
Grant's tree to fix those board files.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
