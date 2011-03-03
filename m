From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCHv2] omap:mailbox: resolve hang issue
Date: Wed, 2 Mar 2011 20:51:41 -0600
Message-ID: <AANLkTin4LUkC=bARTaAweJ96FnVHy9dLqto=yjD=ovaL@mail.gmail.com>
References: <1299104058-28565-1-git-send-email-x0095078@ti.com>
	<20110303014416.GL20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110303014416.GL20560@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Armando Uribe <x0095078@ti.com>, hiroshi.doyu@nokia.com, ohad@wizery.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Hari Kanigeri <h-kanigeri2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 2, 2011 at 7:44 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Armando Uribe <x0095078@ti.com> [110302 13:54]:
>> From: Hari Kanigeri <h-kanigeri2@ti.com>
>>
>> omap4 interrupt disable bits is different. On rx kfifo full, the mbo=
x rx
>> interrupts wasn't getting disabled, and this is causing the rcm stre=
ss tests
>> to hang.
>>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> Signed-off-by: Armando Uribe <x0095078@ti.com>
>> Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
>
> Should we merge this as a fix for the 2.6.38 still?

yeah, if it can still be merged in 2.6.38 because it is a fix it would =
be great.

Regards,
=46ernando.

>
> Tony
>
>> ---
>> =A0arch/arm/mach-omap2/mailbox.c | =A0 10 ++++++----
>> =A01 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mai=
lbox.c
>> index 394413d..011ca50 100644
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -193,10 +193,12 @@ static void omap2_mbox_disable_irq(struct omap=
_mbox *mbox,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mbox_type_t irq)
>> =A0{
>> =A0 =A0 =A0 struct omap_mbox2_priv *p =3D mbox->priv;
>> - =A0 =A0 u32 l, bit =3D (irq =3D=3D IRQ_TX) ? p->notfull_bit : p->n=
ewmsg_bit;
>> - =A0 =A0 l =3D mbox_read_reg(p->irqdisable);
>> - =A0 =A0 l &=3D ~bit;
>> - =A0 =A0 mbox_write_reg(l, p->irqdisable);
>> + =A0 =A0 u32 bit =3D (irq =3D=3D IRQ_TX) ? p->notfull_bit : p->newm=
sg_bit;
>> +
>> + =A0 =A0 if (!cpu_is_omap44xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 bit =3D mbox_read_reg(p->irqdisable) & ~bi=
t;
>> +
>> + =A0 =A0 mbox_write_reg(bit, p->irqdisable);
>> =A0}
>>
>> =A0static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
>> --
>> 1.7.0.4
>>
>
