From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: SmartReflex: pass device dependent data
 via platform data
Date: Wed, 3 Oct 2012 15:05:26 +0200
Message-ID: <CAORVsuWKMHbqKvJ6x3dY0Kz_f2va4O8-fTmazF5tpNp1qLUgPg@mail.gmail.com>
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
 <1348496201-6378-1-git-send-email-j-pihet@ti.com>
 <1348496201-6378-3-git-send-email-j-pihet@ti.com>
 <877gr87bxj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <877gr87bxj.fsf@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: tony@atomide.com, J Keerthy <j-keerthy@ti.com>, Anton Vorontsov <cbou@mail.ru>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

On Wed, Oct 3, 2012 at 12:21 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Hi Jean,
>
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Remove the device dependent settings (cpu_is_xxx(), IP fck etc.)
>> from the driver code and pass them instead via the platform
>> data.
>> This allows a clean separation of the driver code and the platform
>> code, as required by the move of the platform header files to
>> include/linux/platform_data.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Could you make pdata change and the clock change should be two different
> patches?  Also, your previous patch to align SR clock names should be
> combined with the changes made here.
>
> Some comments on the clock change below...
>
>> ---
>>  arch/arm/mach-omap2/sr_device.c   |   13 ++++++++++++
>>  drivers/power/avs/smartreflex.c   |   40 ++++++++++--------------------------
>>  include/linux/power/smartreflex.h |   14 +++++++++++-
>>  3 files changed, 36 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
>> index d033a65..2885a77 100644
>> --- a/arch/arm/mach-omap2/sr_device.c
>> +++ b/arch/arm/mach-omap2/sr_device.c
>> @@ -122,6 +122,19 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
>>       sr_data->senn_mod = 0x1;
>>       sr_data->senp_mod = 0x1;
>>
>> +     if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
>> +             sr_data->err_weight = OMAP3430_SR_ERRWEIGHT;
>> +             sr_data->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
>> +             sr_data->accum_data = OMAP3430_SR_ACCUMDATA;
>> +             if (!(strcmp(sr_data->name, "smartreflex_mpu"))) {
>> +                     sr_data->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
>> +                     sr_data->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
>> +             } else {
>> +                     sr_data->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
>> +                     sr_data->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
>> +             }
>> +     }
>> +
>>       sr_data->voltdm = voltdm_lookup(sr_dev_attr->sensor_voltdm_name);
>>       if (IS_ERR(sr_data->voltdm)) {
>>               pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
>> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
>> index 92f6728..7c03c90 100644
>> --- a/drivers/power/avs/smartreflex.c
>> +++ b/drivers/power/avs/smartreflex.c
>> @@ -128,17 +128,16 @@ static irqreturn_t sr_interrupt(int irq, void *data)
>>
>>  static void sr_set_clk_length(struct omap_sr *sr)
>>  {
>> +     char fck_name[16]; /* "smartreflex.0" fits in 16 chars */
>>       struct clk *sys_ck;
>>       u32 sys_clk_speed;
>>
>> -     if (cpu_is_omap34xx())
>> -             sys_ck = clk_get(NULL, "sys_ck");
>> -     else
>> -             sys_ck = clk_get(NULL, "sys_clkin_ck");
>> +     sprintf(fck_name, "smartreflex.%d", sr->srid);
>
> hmm, isn't this the same as dev_name(&sr->pdev.dev) ?
Yes. Atfer the previous patch "ARM: OMAP: hwmod: align the SmartReflex
fck names" there is a direct mapping between the device name and the
IP functional clock. Note: the mapping is based on the order of the
hwmod entries and so it is important not to move them around.

> Combined with your earlier patch to align clock names, this should just
> be:
>
>         sys_ck = clk_get(&sr->pdev.dev, "fck");
Great! That works great and the code is much more elegant.

> Also note that you've changed this from sys_clk to the SR functional
> clock, which seems to be the same clock on 34xx and 44xx, but that change
> should be clearly documented in the changelog.
Ok.

Updated patch in a bit.

>
> Kevin

Thanks for reviewing,
Jean
