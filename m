From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: CONFIG_DEBUG_SHIRQ and PM
Date: Wed, 26 Aug 2015 17:36:24 -0300
Message-ID: <CAAEAJfAPB1N-xcz+HbHCcF8JaXAVL05CSwpQGi7ea+114mMpmw@mail.gmail.com>
References: <20150825195830.GH27534@saruman.tx.rr.com>
	<CAAEAJfCY1BRuoQCWfD2pCq36E54vDB5Coy2S7rz3RfL2BVLGaw@mail.gmail.com>
	<20150826193820.GT14625@saruman.tx.rr.com>
	<CAAEAJfAPVgxhRnfYJYzebFJDRJ4Ooam6n+0B5HJ-+uLJ0exTLA@mail.gmail.com>
	<20150826200300.GU14625@saruman.tx.rr.com>
	<CAAEAJfB3iiRENEKm6xx-kLae5AR6BV0XVo0KNkb8-okvLjhFhg@mail.gmail.com>
	<20150826202429.GV14625@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150826202429.GV14625@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Ingo Molnar <mingo@elte.hu>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 26 August 2015 at 17:24, Felipe Balbi <balbi@ti.com> wrote:
[..]
>>
>> static irqreturn_t tw68_irq(int irq, void *dev_id)
>> {
>>         struct tw68_dev *dev =3D dev_id;
>>         u32 status, orig;
>>         int loop;
>>
>>         status =3D orig =3D tw_readl(TW68_INTSTAT) & dev->pci_irqmas=
k;
>
> Now try to read that register when your clock is gated. That's the
> problem I'm talking about. Everything about the handler is functionin=
g
> correctly; however clocks are gated in ->remove() and free_irq() is
> only called *AFTER* ->remove() has returned.
>

Yeah, it's pretty clear you are talking about clocks here. That's
why I said "read won't stall" in the next paragraph.

>>         [etc]
>> }
>>
>> The IRQ handler accesses the device struct and then
>> reads through PCI. So if you use devm_request_irq
>> you need to make sure the device struct is still allocated
>> after remove(), and the PCI read won't stall or crash.
>
> dude, that's not the problem I'm talking about. I still have my
> private_data around, what I don't have is:
>
>               _            _
>   __ _    ___| | ___   ___| | __
>  / _` |  / __| |/ _ \ / __| |/ /
> | (_| | | (__| | (_) | (__|   <
>  \__,_|  \___|_|\___/ \___|_|\_\
>
>

Yes, *you* may have your private data around and have a clock gated,
others (the tw68 for instance) may have its region released and unmappe=
d.

And yet others may have $whatever resource released in the
remove() and assume it's available in the IRQ handler.

I honestly can't think why using request_irq / free_irq to solve this
is a workaround.

>> Interestingly, tw68 uses devm_request_irq with IRQF_SHARED :-)
>>
>> Still, I don't think that's a good idea, since it relies on
>> the IRQ being freed *before* the device struct.
>
> that's not an issue at all. If you're using devm_request_irq() you're
> likely using devm_kzalloc() for the device struct anyway. Also, you
> called devm_kzalloc() before devm_request_irq() so IRQ *will* be free=
d
> before your private data; there's nothing wrong there.
>

--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
