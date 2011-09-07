From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 25/25] gpio/omap: handle set_dataout reg capable IP on
	restore
Date: Wed, 7 Sep 2011 13:05:34 +0530
Message-ID: <CAC83ZvJJV1v0akAwv_vM-SaENxvDSpw3v_ckFTBoEqcL+X5QSg@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-26-git-send-email-tarun.kanti@ti.com>
	<87mxehusdg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87mxehusdg.fsf@ti.com>
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
Cc: tony@atomide.com, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 7, 2011 at 5:37 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Nishanth Menon <nm@ti.com>
>>
>> GPIO IP revisions such as those used in OMAP4 have a set_dataout
>> while the previous revisions used a single dataout register.
>> Depending on what is available restore the dataout settings
>> to the right register.
>
> OK, minor nit below...
>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 =A07 ++++++-
>> =A01 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index a629498..4680b4c 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -1334,7 +1334,12 @@ static void omap_gpio_restore_context(struct gpio=
_bank *bank)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base +=
 bank->regs->risingdetect);
>> =A0 =A0 =A0 __raw_writel(bank->context.fallingdetect,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base +=
 bank->regs->fallingdetect);
>> - =A0 =A0 __raw_writel(bank->context.dataout, bank->base + bank->regs->d=
ataout);
>> + =A0 =A0 if (bank->regs->set_dataout && bank->regs->clr_dataout)
>
> Why the check for ->clr_dataout here?
Well, I guess it was just an additional check. It can possibly be removed.
--
Tarun
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.dataout,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base + b=
ank->regs->set_dataout);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.dataout,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base + b=
ank->regs->dataout);
>> =A0 =A0 =A0 __raw_writel(bank->context.oe, bank->base + bank->regs->dire=
ction);
>>
>> =A0 =A0 =A0 if (bank->dbck_enable_mask) {
>
> Kevin
>
