From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v5 09/17] OMAP2,3: DSS2: DSS: create platform_driver, move
 init,exit to driver
Date: Sun, 9 Jan 2011 14:03:13 +0530
Message-ID: <AANLkTimXmFUBxr7fk=JkyMb=YXpk_DULhAj=R8_u=ngY@mail.gmail.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
 <1294399551-10457-10-git-send-email-sumit.semwal@ti.com> <87fwt4i8kd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:57087 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750998Ab1AIIdg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 9 Jan 2011 03:33:36 -0500
Received: by bwz12 with SMTP id 12so12056725bwz.41
        for <linux-omap@vger.kernel.org>; Sun, 09 Jan 2011 00:33:34 -0800 (PST)
In-Reply-To: <87fwt4i8kd.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Hi Kevin,

On Sat, Jan 8, 2011 at 5:13 AM, Kevin Hilman <khilman@ti.com> wrote:
> Sumit Semwal <sumit.semwal@ti.com> writes:
>
>> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>>
>> Hwmod adaptation design requires each of the DSS HW IP to be a platf=
orm driver.
>> So a platform_driver of DSS is created and init exit methods are mov=
ed from core.c
>> to its driver probe,remove. pdev member has to be maintained by its =
own drivers.
>>
>> DSS platform driver is registered from inside omap_dss_probe, in the=
 order desired.
>>
>> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/core.c | =A0 21 +++++++--------
>> =A0drivers/video/omap2/dss/dss.c =A0| =A0 55 +++++++++++++++++++++++=
+++++++++++++++-
>> =A0drivers/video/omap2/dss/dss.h =A0| =A0 =A04 +-
>> =A03 files changed, 65 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/ds=
s/core.c
>> index 48d20d8..faca859 100644
>> --- a/drivers/video/omap2/dss/core.c
>> +++ b/drivers/video/omap2/dss/core.c
>> @@ -497,9 +497,9 @@ static inline void dss_uninitialize_debugfs(void=
)
>> =A0static int omap_dss_probe(struct platform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 struct omap_dss_board_info *pdata =3D pdev->dev.platform=
_data;
>> - =A0 =A0 int skip_init =3D 0;
>> =A0 =A0 =A0 int r;
>> =A0 =A0 =A0 int i;
>> + =A0 =A0 int skip_init =3D 0;
>
> looks like unnessary move.
>
> maybe you meant to remove this var since its usage was removed from t=
his
> function?
>
>> =A0 =A0 =A0 core.pdev =3D pdev;
>>
>> @@ -517,15 +517,9 @@ static int omap_dss_probe(struct platform_devic=
e *pdev)
>> =A0 =A0 =A0 core.ctx_id =3D dss_get_ctx_id();
>> =A0 =A0 =A0 DSSDBG("initial ctx id %u\n", core.ctx_id);
>>
>> -#ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
>> - =A0 =A0 /* DISPC_CONTROL */
>> - =A0 =A0 if (omap_readl(0x48050440) & 1) /* LCD enabled? */
>> - =A0 =A0 =A0 =A0 =A0 =A0 skip_init =3D 1;
>> -#endif
>> -
>> - =A0 =A0 r =3D dss_init(skip_init);
>> + =A0 =A0 r =3D dss_init_platform_driver();
>> =A0 =A0 =A0 if (r) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to initialize DSS\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to initialize DSS platform =
driver\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_dss;
>> =A0 =A0 =A0 }
>>
>> @@ -553,6 +547,11 @@ static int omap_dss_probe(struct platform_devic=
e *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_venc;
>> =A0 =A0 =A0 }
>>
>> +#ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
>> + =A0 =A0 /* DISPC_CONTROL */
>> + =A0 =A0 if (omap_readl(0x48050440) & 1) /* LCD enabled? */
>> + =A0 =A0 =A0 =A0 =A0 =A0 skip_init =3D 1;
>> +#endif
>
> nope, you just moved it here.
>
> But it's also duplicated in dsshw_probe below. =A0Is that needed?
Yes; these two are needed as both dss_init() (which is replaced with
dss_init_platform_driver() in this patch) and also by sdi_init().
sdi_init() is a software init, so it will not be moved to a
platform_driver. That's why we need the #ifdef.. #endif in both
dss_probe() and dsshw_probe().
>
>> =A0 =A0 =A0 if (cpu_is_omap34xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D sdi_init(skip_init);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r) {
>> @@ -610,7 +609,7 @@ err_dispc:
>> =A0err_dpi:
>> =A0 =A0 =A0 rfbi_exit();
>> =A0err_rfbi:
>> - =A0 =A0 dss_exit();
>> + =A0 =A0 dss_deinit_platform_driver();
>
> s/deinit/uninit/ or uninitial
Sure, will change.
>> =A0err_dss:
>> =A0 =A0 =A0 dss_clk_disable_all_no_ctx();
>> =A0 =A0 =A0 dss_put_clocks();
>> @@ -636,7 +635,7 @@ static int omap_dss_remove(struct platform_devic=
e *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdi_exit();
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 dss_exit();
>> + =A0 =A0 dss_deinit_platform_driver();
>>
>> =A0 =A0 =A0 /* these should be removed at some point */
>> =A0 =A0 =A0 c =3D core.dss_ick->usecount;
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss=
/dss.c
>> index 77c3621..ebb294a 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -59,6 +59,7 @@ struct dss_reg {
>> =A0 =A0 =A0 dss_write_reg(idx, FLD_MOD(dss_read_reg(idx), val, start=
, end))
>>
>> =A0static struct {
>> + =A0 =A0 struct platform_device *pdev;
>> =A0 =A0 =A0 void __iomem =A0 =A0*base;
>>
>> =A0 =A0 =A0 struct clk =A0 =A0 =A0*dpll4_m4_ck;
>> @@ -549,7 +550,7 @@ void dss_set_dac_pwrdn_bgz(bool enable)
>> =A0 =A0 =A0 REG_FLD_MOD(DSS_CONTROL, enable, 5, 5); /* DAC Power-Dow=
n Control */
>> =A0}
>>
>> -int dss_init(bool skip_init)
>> +static int dss_init(bool skip_init)
>> =A0{
>> =A0 =A0 =A0 int r;
>> =A0 =A0 =A0 u32 rev;
>> @@ -629,7 +630,7 @@ fail0:
>> =A0 =A0 =A0 return r;
>> =A0}
>>
>> -void dss_exit(void)
>> +static void dss_exit(void)
>> =A0{
>> =A0 =A0 =A0 if (cpu_is_omap34xx())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(dss.dpll4_m4_ck);
>> @@ -639,3 +640,53 @@ void dss_exit(void)
>> =A0 =A0 =A0 iounmap(dss.base);
>> =A0}
>>
>> +/* DSS HW IP initialisation */
>> +static int omap_dsshw_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 int r;
>> + =A0 =A0 int skip_init =3D 0;
>> +
>> + =A0 =A0 dss.pdev =3D pdev;
>> +
>> +#ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
>> + =A0 =A0 /* DISPC_CONTROL */
>> + =A0 =A0 if (omap_readl(0x48050440) & 1) /* LCD enabled? */
>> + =A0 =A0 =A0 =A0 =A0 =A0 skip_init =3D 1;
>> +#endif
>> +
>> + =A0 =A0 r =3D dss_init(skip_init);
>> + =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Failed to initialize DSS\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_dss;
>> + =A0 =A0 }
>> +
>> +err_dss:
>> +
>> + =A0 =A0 return r;
>> +}
>> +
>> +static int omap_dsshw_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 dss_exit();
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver omap_dsshw_driver =3D {
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D omap_dsshw_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_dsshw_remove,
>> + =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap_dss",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 },
>> +};
>> +
>> +int dss_init_platform_driver(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&omap_dsshw_driver);
>> +}
>> +
>> +void dss_deinit_platform_driver(void)
>> +{
>> + =A0 =A0 return platform_driver_unregister(&omap_dsshw_driver);
>> +}
>
> Is there a reason for these extra functions?
>
> Why can't the platform_driver APIs be called directly?
Of all these platform devices (in this and later patches of this
series), the initialization needs to be in a sequence. That's achieved
by calling the init_platform_driver / uninit_platform_driver centrally
from core.c's omap_dss_probe() in the required sequence. Since
platform driver data for each platform device is static within each
platform driver's file, these functions are required.

Best regards,
~Sumit.
>
>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss=
/dss.h
>> index 5c7940d..50b4223 100644
>> --- a/drivers/video/omap2/dss/dss.h
>> +++ b/drivers/video/omap2/dss/dss.h
>> @@ -214,8 +214,8 @@ void dss_overlay_setup_l4_manager(struct omap_ov=
erlay_manager *mgr);
>> =A0void dss_recheck_connections(struct omap_dss_device *dssdev, bool=
 force);
>>
>> =A0/* DSS */
>> -int dss_init(bool skip_init);
>> -void dss_exit(void);
>> +int dss_init_platform_driver(void);
>> +void dss_deinit_platform_driver(void);
>>
>> =A0void dss_save_context(void);
>> =A0void dss_restore_context(void);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
