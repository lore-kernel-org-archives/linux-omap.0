From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v3 08/17] OMAP2,3: DSS2: Create platform_driver for each
 DSS HW IP
Date: Wed, 5 Jan 2011 09:14:10 +0530
Message-ID: <AANLkTinNukLUiYmdL0kejVDEAwo+py136qCyxZWybZLZ@mail.gmail.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
 <1294059069-26737-9-git-send-email-svadivu@ti.com> <87zkrg43ht.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:35529 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750995Ab1AEDob convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 22:44:31 -0500
Received: by mail-qy0-f173.google.com with SMTP id 1so17105572qyk.4
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 19:44:31 -0800 (PST)
In-Reply-To: <87zkrg43ht.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Guruswamy Senthilvadivu <svadivu@ti.com>, tomi.valkeinen@nokia.com, paul@pwsan.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org

Hi Kevin,

On Wed, Jan 5, 2011 at 5:37 AM, Kevin Hilman <khilman@ti.com> wrote:
> Guruswamy Senthilvadivu <svadivu@ti.com> writes:
>
>> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>>
>> Hwmod adaptation design requires each of the DSS HW IP to be a platf=
orm driver.
>> Platform driver of dsshw has to be registered before of dispc, rfbi,=
 dsi1,
>> venc and omapdisplay driver should be after all the HW IPs. Sequence=
 it with
>> arch_initcall and device_initcall_sync.
>>
>> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>
> Rather than creating a bunch of empty/dummy driver here to be populat=
ed
> later, I'd prefer them to be created as needed in the subsequent
> patches.
>
> For example, the dispc parts of this patch should be added in PATCH 9
> where you populate the functions. =A0The RFBI parts of this patch sho=
uld
> be added in PATCH 12, etc. etc.
Thanks for your comments; since Senthil is going to be out for
sometime, I would make these changes and push as the next version;
will wait a bit for other comments too.

Best regards,
~Sumit.
>
> Kevin
>
>
>> ---
>> =A0drivers/video/omap2/dss/core.c =A0| =A0 =A02 +-
>> =A0drivers/video/omap2/dss/dispc.c | =A0 28 ++++++++++++++++++++++++=
++++
>> =A0drivers/video/omap2/dss/dsi.c =A0 | =A0 29 ++++++++++++++++++++++=
++++++-
>> =A0drivers/video/omap2/dss/dss.c =A0 | =A0 27 ++++++++++++++++++++++=
+++++
>> =A0drivers/video/omap2/dss/rfbi.c =A0| =A0 28 ++++++++++++++++++++++=
++++++
>> =A0drivers/video/omap2/dss/venc.c =A0| =A0 28 ++++++++++++++++++++++=
++++++
>> =A06 files changed, 140 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/ds=
s/core.c
>> index 48d20d8..d165434 100644
>> --- a/drivers/video/omap2/dss/core.c
>> +++ b/drivers/video/omap2/dss/core.c
>> @@ -989,7 +989,7 @@ static int __init omap_dss_init2(void)
>> =A0}
>>
>> =A0core_initcall(omap_dss_init);
>> -device_initcall(omap_dss_init2);
>> +device_initcall_sync(omap_dss_init2);
>> =A0#endif
>>
>> =A0MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/d=
ss/dispc.c
>> index fa40fa5..942dea5 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -3167,3 +3167,31 @@ int dispc_setup_plane(enum omap_plane plane,
>>
>> =A0 =A0 =A0 return r;
>> =A0}
>> +
>> +/* DISPC HW IP initialisation */
>> +static int omap_dispchw_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_dispchw_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver omap_dispchw_driver =3D {
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D omap_dispchw_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_dispchw_remove,
>> + =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap_dispc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 },
>> +};
>> +
>> +static int __init omap_dispc_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&omap_dispchw_driver);
>> +}
>> +
>> +device_initcall(omap_dispc_init);
>> +
>> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss=
/dsi.c
>> index aa4f7a5..037d366 100644
>> --- a/drivers/video/omap2/dss/dsi.c
>> +++ b/drivers/video/omap2/dss/dsi.c
>> @@ -292,7 +292,6 @@ static inline u32 dsi_read_reg(const struct dsi_=
reg idx)
>> =A0 =A0 =A0 return __raw_readl(dsi.base + idx.idx);
>> =A0}
>>
>> -
>> =A0void dsi_save_context(void)
>> =A0{
>> =A0}
>> @@ -3304,3 +3303,31 @@ void dsi_exit(void)
>> =A0 =A0 =A0 DSSDBG("omap_dsi_exit\n");
>> =A0}
>>
>> +/* DSI1 HW IP initialisation */
>> +static int omap_dsi1hw_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_dsi1hw_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver omap_dsi1hw_driver =3D {
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D omap_dsi1hw_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_dsi1hw_remove,
>> + =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap_dsi1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 },
>> +};
>> +
>> +static int __init omap_dsi1_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&omap_dsi1hw_driver);
>> +}
>> +
>> +device_initcall(omap_dsi1_init);
>> +
>> +
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss=
/dss.c
>> index 77c3621..6d0bd89 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -639,3 +639,30 @@ void dss_exit(void)
>> =A0 =A0 =A0 iounmap(dss.base);
>> =A0}
>>
>> +/* DSS HW IP initialisation */
>> +static int omap_dsshw_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_dsshw_remove(struct platform_device *pdev)
>> +{
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
>> +static int __init omap_dss_init1(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&omap_dsshw_driver);
>> +}
>> +
>> +arch_initcall(omap_dss_init1);
>> +
>> diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/ds=
s/rfbi.c
>> index bbe6246..a086233 100644
>> --- a/drivers/video/omap2/dss/rfbi.c
>> +++ b/drivers/video/omap2/dss/rfbi.c
>> @@ -1054,3 +1054,31 @@ int rfbi_init_display(struct omap_dss_device =
*dssdev)
>> =A0 =A0 =A0 dssdev->caps =3D OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
>> =A0 =A0 =A0 return 0;
>> =A0}
>> +
>> +/* RFBI HW IP initialisation */
>> +static int omap_rfbihw_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_rfbihw_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver omap_rfbihw_driver =3D {
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D omap_rfbihw_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_rfbihw_remove,
>> + =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap_rfbi",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 },
>> +};
>> +
>> +static int __init omap_rfbi_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&omap_rfbihw_driver);
>> +}
>> +
>> +device_initcall(omap_rfbi_init);
>> +
>> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/ds=
s/venc.c
>> index eff3505..ac63cee 100644
>> --- a/drivers/video/omap2/dss/venc.c
>> +++ b/drivers/video/omap2/dss/venc.c
>> @@ -740,3 +740,31 @@ void venc_dump_regs(struct seq_file *s)
>>
>> =A0#undef DUMPREG
>> =A0}
>> +
>> +/* VENC HW IP initialisation */
>> +static int omap_venchw_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int omap_venchw_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver omap_venchw_driver =3D {
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D omap_venchw_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_venchw_remove,
>> + =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap_venc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 },
>> +};
>> +
>> +static int __init omap_venc_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&omap_venchw_driver);
>> +}
>> +
>> +device_initcall(omap_venc_init);
>> +
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
