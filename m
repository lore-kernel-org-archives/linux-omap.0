From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v8 24/24] gpio/omap: handle set_dataout reg capable IP on
 restore
Date: Wed, 23 Nov 2011 18:01:35 +0530
Message-ID: <CAC83ZvL9w=7RhAuT=5ahbDX+d6miQMif1ngOenEiqP4UN2+mzg@mail.gmail.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
 <1317803593-12259-25-git-send-email-tarun.kanti@ti.com>
 <87aa8bde2d.fsf@ti.com>
 <CAC83Zv+gac_Wd8+V+o6USxv73ia5i8JLjLDHj8VQiRiqZ7DOtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAC83Zv+gac_Wd8+V+o6USxv73ia5i8JLjLDHj8VQiRiqZ7DOtQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 7, 2011 at 5:35 PM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Fri, Nov 4, 2011 at 10:23 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> From: Nishanth Menon <nm@ti.com>
>>>
>>> GPIO IP revisions such as those used in OMAP4 have a set_dataout
>>> while the previous revisions used a single dataout register.
>>> Depending on what is available restore the dataout settings
>>> to the right register.
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>>> =A0drivers/gpio/gpio-omap.c | =A0 =A09 +++++++--
>>> =A01 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index 4009446..3df7a98 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -1073,7 +1073,7 @@ static int __devinit omap_gpio_probe(struct platf=
orm_device *pdev)
>>> =A0 =A0 =A0 bank->get_context_loss_count =3D pdata->get_context_loss_co=
unt;
>>> =A0 =A0 =A0 bank->regs =3D pdata->regs;
>>>
>>> - =A0 =A0 if (bank->regs->set_dataout && bank->regs->clr_dataout)
>>> + =A0 =A0 if (bank->regs->set_dataout)
>>
>> This change isn't right.
>>
>> The _set_gpio_dataout_reg function depends on the existence of
>> ->clr_dataout too.
> Ok, I will add the clr_dataout condtion as well.

>
>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->set_dataout =3D _set_gpio_dataout_reg;
>>> =A0 =A0 =A0 else
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->set_dataout =3D _set_gpio_dataout_mas=
k;
>>> @@ -1351,7 +1351,12 @@ static void omap_gpio_restore_context(struct gpi=
o_bank *bank)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base =
+ bank->regs->risingdetect);
>>> =A0 =A0 =A0 __raw_writel(bank->context.fallingdetect,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base =
+ bank->regs->fallingdetect);
>>> - =A0 =A0 __raw_writel(bank->context.dataout, bank->base + bank->regs->=
dataout);
>>> + =A0 =A0 if (bank->regs->set_dataout)
>>
>> Why the check again? =A0The check has already been done in probe.
>>
>> Just use bank->set_dataout() here.
> Sure, i will make the change.
When I look at the signature of set_dataout(), it does not seem straight fo=
rward
to be used here. It expects (struct gpio_bank *bank, int gpio, int enable) =
to be
passed to it.
set_dataout (struct gpio_bank *bank, int gpio, int enable)
{
        void __iomem *reg =3D bank->base;
        u32 l =3D GPIO_BIT(bank, gpio);
...
        if (enable)
...
        else
...
        __raw_writel(l, reg);

}
--
Tarun
