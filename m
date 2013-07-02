From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: RT and omap-gpio irqchip with DeviceTree
Date: Tue, 2 Jul 2013 17:51:14 +0200
Message-ID: <CAAwP0s1JCyWTS=TXKPOCuUtZr8a7Ufy=k2hMAswZQ37wWqyu7w@mail.gmail.com>
References: <20130702114452.GA13763@localhost.localdomain> <CAAwP0s2KUCowe5scWJtiZ8hZb-5EMbmef_WO_03cY3H7DqxSOQ@mail.gmail.com>
 <20130702143130.GC27329@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:62480 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab3GBPvf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 11:51:35 -0400
In-Reply-To: <20130702143130.GC27329@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Torben Hohn <torbenh@linutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, tglx@linutronix.de, bigeasy@linutronix.de, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org

On Tue, Jul 2, 2013 at 4:31 PM, Torben Hohn <torbenh@linutronix.de> wro=
te:
> On Tue, Jul 02, 2013 at 02:15:46PM +0200, Javier Martinez Canillas wr=
ote:
>> + Grant, Linus W and Jean-Christophe.
>>
>> On Tue, Jul 2, 2013 at 1:44 PM, Torben Hohn <torbenh@linutronix.de> =
wrote:
>> >
>> > Hi..
>> >
>> > I am running into Problems with a network adapter IRQ connected to=
 an
>> > omap-gpio pin.
>> >
>> > omap-gpio expects gpio-request() to be called before i can use the=
 pin.
>> > But this is abstracted via the DeviceTree bindings.
>> >
>> > I see 8d4c277e185c31359cf70573d8b0351fb7dd0dfe in mainline.
>> > This one just puts a warning into the exact place, i am dealing wi=
th.
>> > But i need to make this work, instead of bailing out.
>> >
>>
>> This has been discussed extensively on the linux-omap mailing list a=
nd
>> the agreement is that it has to be handled by the IRQ core. So when =
a
>> GPIO line is mapped in the IRQ domain with irq_create_of_mapping(),
>> the core has to take care to request the GPIO and configure it as
>> input.
>
> Can you give me a pointer to this discussion please ?
> Because i fail to understand why you just dont save the irq_type in s=
ome
> private data structure, and then use chip->irq_enable() or something.
>
>

Yes, it starts here [1] but it the thread is 90+ mails long.

>>
>>  But until we have this general solution we have to do it on a per i=
rq
>> chip driver basis and the less hack-ish solution is to have a custom
>> .map function handler that request the GPIO used as IRQ.
>>
>> There is already a patch [1] queued in Linus Walleij linux-gpio tree
>> [2] for-next branch that implements this for OMAP GPIO. It would be
>> great if you can test it and give feedback.
>
> Thanks for the pointer.
> The kernel i am working on is based on 3.8.x (this is before the
> irq_domain change to linear)
>
> First i only backported: [1] and [2]
>
> With these i see big streams like these:
> [    1.554809] omap_gpio gpio.9: Could not request GPIO-256
> [    1.560394] omap_gpio gpio.9: Could not request GPIO-255
> [    1.566009] omap_gpio gpio.9: Could not request GPIO-254
> [    1.571594] omap_gpio gpio.9: Could not request GPIO-253
> [    1.577178] omap_gpio gpio.9: Could not request GPIO-252
> [    1.582794] omap_gpio gpio.9: Could not request GPIO-251
>
> This is basically coming from irq_domain_add_legacy() which calls
> ops->map(domain, irq, hwirq) before the gpio chip is actually added.
>
> I fixed it by also taking [3].
>

Yes, sorry for not mentioning that it has as a dependency the legacy
to linear domain mapping change. I didn't mentioned since I thought
that you were basing your work on mainline.

> However, OMAP1 is still calling irq_domain_add_legacy(). This would
> probably break with DeviceTree.

Indeed, OMAP1 doesn't support DT. In fact if you are interested in
OMAP1, then you need to cherry-pick another patch from mainline since
linear domain mapping does not work with OMAP1 because OMAP1 does not
support SPARSE_IRQ. That's why the change from legacy to linear domain
mapping was partially reverted for OMAP1 in mainline commit 397eada9
("gpio/omap: don't use linear domain mapping for OMAP1")

> But since omap1 doesnt use DeviceTree, this is probably a non-issue.
>

Yes, the GPIO is only requested on the .map function handler if
bank->chip.of_node is not NULL so it doesn't have a side effect on
platforms that don't support DT.

After all, this issue has only been detected once we migrated to DT
since for legacy booting is the platform code the responsible to do
this setup (e.g: configuring the OMAP pin mux, request the GPIO,
configure it as input, etc).

> [1] https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.gi=
t/commit/?h=3Dfor-next&id=3D570c4bb53366157fa076922d0fc7e7adfd81cf42
> [2] https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.gi=
t/commit/?h=3Dfor-next&id=3D50fc1d067d9f4b6c99717b91c1aaaa618075f859
> [3] https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.gi=
t/commit/?h=3Dfor-next&id=3Dede4d7a5b9835510fd1f724367f68d2fa4128453
>
>
> --
> Mit freundlichen Gr=C3=BC=C3=9Fen
> Torben Hohn
>
> Linutronix GmbH
>
> Standort: Bremen
>
> Phone: +49 421 5650 2310 ; Fax.: +49 7556 919 886
> mailto: torbenh@linutronix.de
> Firmensitz / Registered Office: D-88690 Uhldingen, Auf dem Berg 3
> Registergericht / Local District Court: Freiburg i. Br., HRB Nr. / Tr=
ade
> register no.: 700 806;
>
> Gesch=C3=A4ftsf=C3=BChrer / Managing Directors: Heinz Egger, Thomas G=
leixner

Best regards,
Javier

[1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85544.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
