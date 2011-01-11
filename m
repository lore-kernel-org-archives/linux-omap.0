From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 7/7 v2] OMAP: runtime: McSPI driver runtime conversion
Date: Tue, 11 Jan 2011 20:00:20 +0530
Message-ID: <AANLkTi=y3Xb8Vk+m3-wxNn1qaxT87Edu8RsUKYnF0c2n@mail.gmail.com>
References: <33542.10.24.255.18.1291212131.squirrel@dbdmail.itg.ti.com>
 <20101230192957.GD2713@angua.secretlab.ca> <877hegl47q.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40247 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075Ab1AKOan convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 09:30:43 -0500
Received: by wyb28 with SMTP id 28so20515441wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Jan 2011 06:30:42 -0800 (PST)
In-Reply-To: <877hegl47q.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, tony@atomide.com, p-basak2@ti.com

On Sat, Jan 8, 2011 at 4:19 AM, Kevin Hilman <khilman@ti.com> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>
>> On Wed, Dec 01, 2010 at 07:32:11PM +0530, Govindraj.R wrote:
>>> McSPI runtime conversion.
>>> Changes involves:
>>> 1) remove clock framework apis to use runtime framework apis.
>>> 2) context restore from runtime resume which is a callback for get_=
sync.
>>> 3) Remove SYSCONFIG(sysc) register handling
>>> =A0 =A0 =A0 =A0 (a) Remove context save and restore of sysc reg and=
 remove soft reset
>>> =A0 =A0 =A0 =A0 =A0 =A0 done from sysc reg as this will be done wit=
h hwmod framework.
>>> =A0 =A0 =A0 =A0 (b) Also cleanup sysc reg bit macros.
>>> 4) Rename the omap2_mcspi_reset function to omap2_mcspi_master_setu=
p
>>> =A0 =A0function as with hwmod changes soft reset will be done in
>>> =A0 =A0hwmod framework itself and use the return value from clock
>>> =A0 =A0enable function to return for failure scenarios.
>>>
>>> Signed-off-by: Charulatha V <charu@ti.com>
>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> Reviewed-by: Partha Basak <p-basak2@ti.com>
>>
>> One comment below, but otherwise looks good to me. =A0Since the majo=
rity
>> of the changes are in arch/arm, feel free to add my Acked-by for the
>> whole series and merge via the omap tree.
>
> Thanks, we'll merge this through the OMAP tree.
>
>> None of my comments are showstoppers, so I'm even fine with merging
>> them as-is as long as followup patches are posted to address the
>> comments.
>
> Govindraj, since we've missed 2.6.38 for this series, I'd like to see=
 the last few
> minor issues cleaned up before merge, especially the various casting =
and
> CodingStyle issues that Grant found.

Yes sure will post out v3 in a weeks time. Fixing comments and
adding ack from Grant.

--
Thanks,
Govindraj.R


>
> Kevin
>
>> In particular, I'd really like to see the data duplication issue fro=
m
>> the first 4 patches addressed.
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
>>
>>> ---
>>> =A0drivers/spi/omap2_mcspi.c | =A0120 +++++++++++++++++------------=
---------------
>>> =A01 files changed, 46 insertions(+), 74 deletions(-)
>>>
>>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>>> index ad3811e..a1b157f 100644
>>> --- a/drivers/spi/omap2_mcspi.c
>>> +++ b/drivers/spi/omap2_mcspi.c
>>> @@ -33,6 +33,7 @@
>>> =A0#include <linux/clk.h>
>>> =A0#include <linux/io.h>
>>> =A0#include <linux/slab.h>
>>> +#include <linux/pm_runtime.h>
>>>
>>> =A0#include <linux/spi/spi.h>
>>>
>>> @@ -46,7 +47,6 @@
>>> =A0#define OMAP2_MCSPI_MAX_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04
>>>
>>> =A0#define OMAP2_MCSPI_REVISION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00
>>> -#define OMAP2_MCSPI_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x10
>>> =A0#define OMAP2_MCSPI_SYSSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x14
>>> =A0#define OMAP2_MCSPI_IRQSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x18
>>> =A0#define OMAP2_MCSPI_IRQENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1c
>>> @@ -63,13 +63,6 @@
>>>
>>> =A0/* per-register bitmasks: */
>>>
>>> -#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE =A0 =A0 BIT(4)
>>> -#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP =A0 =A0 BIT(2)
>>> -#define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE =A0 =A0 =A0BIT(0)
>>> -#define OMAP2_MCSPI_SYSCONFIG_SOFTRESET =A0 =A0 BIT(1)
>>> -
>>> -#define OMAP2_MCSPI_SYSSTATUS_RESETDONE =A0 =A0 BIT(0)
>>> -
>>> =A0#define OMAP2_MCSPI_MODULCTRL_SINGLE =A0 =A0 =A0 =A0BIT(0)
>>> =A0#define OMAP2_MCSPI_MODULCTRL_MS =A0 =A0BIT(2)
>>> =A0#define OMAP2_MCSPI_MODULCTRL_STEST BIT(3)
>>> @@ -122,13 +115,12 @@ struct omap2_mcspi {
>>> =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
>>> =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0msg_queue;
>>> =A0 =A0 =A0struct spi_master =A0 =A0 =A0 *master;
>>> - =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*ick;
>>> - =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*fck;
>>> =A0 =A0 =A0/* Virtual base address of the controller */
>>> =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0*base;
>>> =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 phys;
>>> =A0 =A0 =A0/* SPI1 has 4 channels, while SPI2 has 2 */
>>> =A0 =A0 =A0struct omap2_mcspi_dma =A0*dma_channels;
>>> + =A0 =A0struct =A0device =A0 =A0 =A0 =A0 =A0*dev;
>>
>> Inconsistent indentation with the rest of the structure (tabs vs. sp=
aces).
>>
>>> =A0};
>>>
>>> =A0struct omap2_mcspi_cs {
>>> @@ -144,7 +136,6 @@ struct omap2_mcspi_cs {
>>> =A0 * corresponding registers are modified.
>>> =A0 */
>>> =A0struct omap2_mcspi_regs {
>>> - =A0 =A0u32 sysconfig;
>>> =A0 =A0 =A0u32 modulctrl;
>>> =A0 =A0 =A0u32 wakeupenable;
>>> =A0 =A0 =A0struct list_head cs;
>>> @@ -268,9 +259,6 @@ static void omap2_mcspi_restore_ctx(struct omap=
2_mcspi *mcspi)
>>> =A0 =A0 =A0mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_mcspi_ctx[spi_cntr=
l->bus_num - 1].modulctrl);
>>>
>>> - =A0 =A0mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_mcspi_ctx[spi_cntrl-=
>bus_num - 1].sysconfig);
>>> -
>>> =A0 =A0 =A0mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_mcspi_ctx[spi_cntr=
l->bus_num - 1].wakeupenable);
>>>
>>> @@ -280,20 +268,12 @@ static void omap2_mcspi_restore_ctx(struct om=
ap2_mcspi *mcspi)
>>> =A0}
>>> =A0static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi=
)
>>> =A0{
>>> - =A0 =A0clk_disable(mcspi->ick);
>>> - =A0 =A0clk_disable(mcspi->fck);
>>> + =A0 =A0pm_runtime_put_sync(mcspi->dev);
>>> =A0}
>>>
>>> =A0static int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
>>> =A0{
>>> - =A0 =A0if (clk_enable(mcspi->ick))
>>> - =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>>> - =A0 =A0if (clk_enable(mcspi->fck))
>>> - =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>>> -
>>> - =A0 =A0omap2_mcspi_restore_ctx(mcspi);
>>> -
>>> - =A0 =A0return 0;
>>> + =A0 =A0return pm_runtime_get_sync(mcspi->dev);
>>> =A0}
>>>
>>> =A0static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned lo=
ng bit)
>>> @@ -819,8 +799,9 @@ static int omap2_mcspi_setup(struct spi_device =
*spi)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>>> =A0 =A0 =A0}
>>>
>>> - =A0 =A0if (omap2_mcspi_enable_clocks(mcspi))
>>> - =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>>> + =A0 =A0ret =3D omap2_mcspi_enable_clocks(mcspi);
>>> + =A0 =A0if (ret < 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0return ret;
>>>
>>> =A0 =A0 =A0ret =3D omap2_mcspi_setup_transfer(spi, NULL);
>>> =A0 =A0 =A0omap2_mcspi_disable_clocks(mcspi);
>>> @@ -863,10 +844,11 @@ static void omap2_mcspi_work(struct work_stru=
ct *work)
>>> =A0 =A0 =A0struct omap2_mcspi =A0 =A0 =A0*mcspi;
>>>
>>> =A0 =A0 =A0mcspi =3D container_of(work, struct omap2_mcspi, work);
>>> - =A0 =A0spin_lock_irq(&mcspi->lock);
>>>
>>> - =A0 =A0if (omap2_mcspi_enable_clocks(mcspi))
>>> - =A0 =A0 =A0 =A0 =A0 =A0goto out;
>>> + =A0 =A0if (omap2_mcspi_enable_clocks(mcspi) < 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0return;
>>> +
>>> + =A0 =A0spin_lock_irq(&mcspi->lock);
>>>
>>> =A0 =A0 =A0/* We only enable one channel at a time -- the one whose=
 message is
>>> =A0 =A0 =A0 * at the head of the queue -- although this controller =
would gladly
>>> @@ -979,10 +961,9 @@ static void omap2_mcspi_work(struct work_struc=
t *work)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irq(&mcspi->lock);
>>> =A0 =A0 =A0}
>>>
>>> - =A0 =A0omap2_mcspi_disable_clocks(mcspi);
>>> -
>>> -out:
>>> =A0 =A0 =A0spin_unlock_irq(&mcspi->lock);
>>> +
>>> + =A0 =A0omap2_mcspi_disable_clocks(mcspi);
>>> =A0}
>>>
>>> =A0static int omap2_mcspi_transfer(struct spi_device *spi, struct s=
pi_message *m)
>>> @@ -1063,25 +1044,15 @@ static int omap2_mcspi_transfer(struct spi_=
device *spi, struct spi_message
>>> *m)
>>> =A0 =A0 =A0return 0;
>>> =A0}
>>>
>>> -static int __init omap2_mcspi_reset(struct omap2_mcspi *mcspi)
>>> +static int __init omap2_mcspi_master_setup(struct omap2_mcspi *mcs=
pi)
>>> =A0{
>>> =A0 =A0 =A0struct spi_master =A0 =A0 =A0 *master =3D mcspi->master;
>>> =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp;
>>> + =A0 =A0int ret =3D 0;
>>>
>>> - =A0 =A0if (omap2_mcspi_enable_clocks(mcspi))
>>> - =A0 =A0 =A0 =A0 =A0 =A0return -1;
>>> -
>>> - =A0 =A0mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP2_MCSPI_SYSCONFIG_SOFT=
RESET);
>>> - =A0 =A0do {
>>> - =A0 =A0 =A0 =A0 =A0 =A0tmp =3D mcspi_read_reg(master, OMAP2_MCSPI=
_SYSSTATUS);
>>> - =A0 =A0} while (!(tmp & OMAP2_MCSPI_SYSSTATUS_RESETDONE));
>>> -
>>> - =A0 =A0tmp =3D OMAP2_MCSPI_SYSCONFIG_AUTOIDLE |
>>> - =A0 =A0 =A0 =A0 =A0 =A0OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP |
>>> - =A0 =A0 =A0 =A0 =A0 =A0OMAP2_MCSPI_SYSCONFIG_SMARTIDLE;
>>> - =A0 =A0mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG, tmp);
>>> - =A0 =A0omap2_mcspi_ctx[master->bus_num - 1].sysconfig =3D tmp;
>>> + =A0 =A0ret =3D omap2_mcspi_enable_clocks(mcspi);
>>> + =A0 =A0if (ret < 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0return ret;
>>>
>>> =A0 =A0 =A0tmp =3D OMAP2_MCSPI_WAKEUPENABLE_WKEN;
>>> =A0 =A0 =A0mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE, tmp);
>>> @@ -1092,6 +1063,18 @@ static int __init omap2_mcspi_reset(struct o=
map2_mcspi *mcspi)
>>> =A0 =A0 =A0return 0;
>>> =A0}
>>>
>>> +static int omap_mcspi_runtime_resume(struct device *dev)
>>> +{
>>> + =A0 =A0struct omap2_mcspi =A0 =A0 =A0*mcspi;
>>> + =A0 =A0struct spi_master =A0 =A0 =A0 *master;
>>> +
>>> + =A0 =A0master =3D dev_get_drvdata(dev);
>>> + =A0 =A0mcspi =3D spi_master_get_devdata(master);
>>> + =A0 =A0omap2_mcspi_restore_ctx(mcspi);
>>> +
>>> + =A0 =A0return 0;
>>> +}
>>> +
>>>
>>> =A0static int __init omap2_mcspi_probe(struct platform_device *pdev=
)
>>> =A0{
>>> @@ -1142,34 +1125,22 @@ static int __init omap2_mcspi_probe(struct =
platform_device *pdev)
>>> =A0 =A0 =A0if (!mcspi->base) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&pdev->dev, "can't ioremap MCSPI=
\n");
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENOMEM;
>>> - =A0 =A0 =A0 =A0 =A0 =A0goto err1aa;
>>> + =A0 =A0 =A0 =A0 =A0 =A0goto err2;
>>> =A0 =A0 =A0}
>>>
>>> + =A0 =A0mcspi->dev =3D &pdev->dev;
>>> =A0 =A0 =A0INIT_WORK(&mcspi->work, omap2_mcspi_work);
>>>
>>> =A0 =A0 =A0spin_lock_init(&mcspi->lock);
>>> =A0 =A0 =A0INIT_LIST_HEAD(&mcspi->msg_queue);
>>> =A0 =A0 =A0INIT_LIST_HEAD(&omap2_mcspi_ctx[master->bus_num - 1].cs)=
;
>>>
>>> - =A0 =A0mcspi->ick =3D clk_get(&pdev->dev, "ick");
>>> - =A0 =A0if (IS_ERR(mcspi->ick)) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&pdev->dev, "can't get mcspi_ick\n=
");
>>> - =A0 =A0 =A0 =A0 =A0 =A0status =3D PTR_ERR(mcspi->ick);
>>> - =A0 =A0 =A0 =A0 =A0 =A0goto err1a;
>>> - =A0 =A0}
>>> - =A0 =A0mcspi->fck =3D clk_get(&pdev->dev, "fck");
>>> - =A0 =A0if (IS_ERR(mcspi->fck)) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&pdev->dev, "can't get mcspi_fck\n=
");
>>> - =A0 =A0 =A0 =A0 =A0 =A0status =3D PTR_ERR(mcspi->fck);
>>> - =A0 =A0 =A0 =A0 =A0 =A0goto err2;
>>> - =A0 =A0}
>>> -
>>> =A0 =A0 =A0mcspi->dma_channels =3D kcalloc(master->num_chipselect,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(struct omap2_mcsp=
i_dma),
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
>>>
>>> =A0 =A0 =A0if (mcspi->dma_channels =3D=3D NULL)
>>> - =A0 =A0 =A0 =A0 =A0 =A0goto err3;
>>> + =A0 =A0 =A0 =A0 =A0 =A0goto err2;
>>>
>>> =A0 =A0 =A0for (i =3D 0; i < master->num_chipselect; i++) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0char dma_ch_name[14];
>>> @@ -1199,8 +1170,10 @@ static int __init omap2_mcspi_probe(struct p=
latform_device *pdev)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0mcspi->dma_channels[i].dma_tx_sync_dev =3D=
 dma_res->start;
>>> =A0 =A0 =A0}
>>>
>>> - =A0 =A0if (omap2_mcspi_reset(mcspi) < 0)
>>> - =A0 =A0 =A0 =A0 =A0 =A0goto err4;
>>> + =A0 =A0pm_runtime_enable(&pdev->dev);
>>> +
>>> + =A0 =A0if (status || omap2_mcspi_master_setup(mcspi) < 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0goto err3;
>>>
>>> =A0 =A0 =A0status =3D spi_register_master(master);
>>> =A0 =A0 =A0if (status < 0)
>>> @@ -1209,17 +1182,13 @@ static int __init omap2_mcspi_probe(struct =
platform_device *pdev)
>>> =A0 =A0 =A0return status;
>>>
>>> =A0err4:
>>> - =A0 =A0kfree(mcspi->dma_channels);
>>> + =A0 =A0spi_master_put(master);
>>> =A0err3:
>>> - =A0 =A0clk_put(mcspi->fck);
>>> + =A0 =A0kfree(mcspi->dma_channels);
>>> =A0err2:
>>> - =A0 =A0clk_put(mcspi->ick);
>>> -err1a:
>>> - =A0 =A0iounmap(mcspi->base);
>>> -err1aa:
>>> =A0 =A0 =A0release_mem_region(r->start, (r->end - r->start) + 1);
>>> + =A0 =A0iounmap(mcspi->base);
>>> =A0err1:
>>> - =A0 =A0spi_master_put(master);
>>> =A0 =A0 =A0return status;
>>> =A0}
>>>
>>> @@ -1235,9 +1204,7 @@ static int __exit omap2_mcspi_remove(struct p=
latform_device *pdev)
>>> =A0 =A0 =A0mcspi =3D spi_master_get_devdata(master);
>>> =A0 =A0 =A0dma_channels =3D mcspi->dma_channels;
>>>
>>> - =A0 =A0clk_put(mcspi->fck);
>>> - =A0 =A0clk_put(mcspi->ick);
>>> -
>>> + =A0 =A0omap2_mcspi_disable_clocks(mcspi);
>>> =A0 =A0 =A0r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> =A0 =A0 =A0release_mem_region(r->start, (r->end - r->start) + 1);
>>>
>>> @@ -1252,10 +1219,15 @@ static int __exit omap2_mcspi_remove(struct=
 platform_device *pdev)
>>> =A0/* work with hotplug and coldplug */
>>> =A0MODULE_ALIAS("platform:omap2_mcspi");
>>>
>>> +static const struct dev_pm_ops omap_mcspi_dev_pm_ops =3D {
>>> + =A0 =A0.runtime_resume =3D omap_mcspi_runtime_resume,
>>> +};
>>> +
>>> =A0static struct platform_driver omap2_mcspi_driver =3D {
>>> =A0 =A0 =A0.driver =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D =A0 =A0 =A0 =A0 "omap2_mcspi",
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D =A0 =A0 =A0 =A0THIS_MODULE,
>>> + =A0 =A0 =A0 =A0 =A0 =A0.pm =3D &omap_mcspi_dev_pm_ops,
>>> =A0 =A0 =A0},
>>> =A0 =A0 =A0.remove =3D =A0 =A0 =A0 __exit_p(omap2_mcspi_remove),
>>> =A0};
>>> --
>>> 1.7.1
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
