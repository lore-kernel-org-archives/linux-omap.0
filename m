From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v3 12/13] gpio/omap: fix incorrect context restore logic
 in omap_gpio_runtime_resume
Date: Thu, 8 Mar 2012 09:28:53 +0530
Message-ID: <CAC83ZvLFoSppTiPw-_a=z_Mnpmk6nHeaadTShdJP8RpDWh9TLg@mail.gmail.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-13-git-send-email-tarun.kanti@ti.com>
 <4F574F95.7090801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F574F95.7090801@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 7, 2012 at 5:37 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Wednesday 07 March 2012 12:16 PM, Tarun Kanti DebBarma wrote:
>> In omap_gpio_runtime_resume() the context restore should be independent
>> of bank->enabled_non_wakeup_gpios. This was preventing context restore
>> of GPIO lines which are not wakeup enabled.
>>
>> Reported-by: Govindraj Raja <govindraj.raja@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 2e8e476..ccfbae0 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -1227,7 +1227,7 @@ static int omap_gpio_runtime_resume(struct device =
*dev)
>> =A0 =A0 =A0 __raw_writel(bank->context.risingdetect,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->base + bank->regs->risingde=
tect);
>>
>> - =A0 =A0 if (!bank->enabled_non_wakeup_gpios || !bank->workaround_enabl=
ed) {
>> + =A0 =A0 if (!bank->workaround_enabled) {
> This doesn't seem to be right.
> Don't you want to avoid GPIO restore for banks which are in
> always on domain. Infact the purpose of "enabled_non_wakeup_gpios"
> is exactly that ? Isn't it.
>
> What am I missing ?
The bank->enabled_non_wakeup_gpios is set whenever a gpio line is programmed
as edge trigger as shown below.
(This is not meant to distinguish between gpios in WKUP domain vs
those in PER domain).
The context restore should happen irrespective of whether the trigger
type is edge or level.
In fact context restore was not happening for a gpio line because of
this condition while
testing suspend/resume.

[...]
                if (trigger & IRQ_TYPE_EDGE_BOTH)
                        bank->enabled_non_wakeup_gpios |=3D gpio_bit;
                else
                        bank->enabled_non_wakeup_gpios &=3D ~gpio_bit;
[...]
--
Tarun

>
> Regards
> Santosh
