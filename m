From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v3 09/10] OMAP4: DSS2: HDMI: Function pointer approach to call
Date: Mon, 5 Sep 2011 23:03:35 +0530
Message-ID: <CAP5A+B__VLN4Vr3v3Q7GXdKoxicTFOFQaTs8-UnoVC+XXRTETA@mail.gmail.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
 <1314960470-2616-2-git-send-email-mythripk@ti.com> <1314960470-2616-3-git-send-email-mythripk@ti.com>
 <1314960470-2616-4-git-send-email-mythripk@ti.com> <1314960470-2616-5-git-send-email-mythripk@ti.com>
 <1314960470-2616-6-git-send-email-mythripk@ti.com> <1314960470-2616-7-git-send-email-mythripk@ti.com>
 <1314960470-2616-8-git-send-email-mythripk@ti.com> <1314960470-2616-9-git-send-email-mythripk@ti.com>
 <1314960470-2616-10-git-send-email-mythripk@ti.com> <1315220503.3214.28.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:46640 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751922Ab1IERd5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Sep 2011 13:33:57 -0400
Received: by mail-vw0-f54.google.com with SMTP id 18so5282268vws.13
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 10:33:55 -0700 (PDT)
In-Reply-To: <1315220503.3214.28.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Mon, Sep 5, 2011 at 4:31 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Fri, 2011-09-02 at 16:17 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> To make the current hdmi DSS driver compatible with future OMAP havi=
ng
>> different IP blocks( A combination of different core, PHY, PLL block=
s),
>> Add HDMI hdmi functions as a function pointer in dss_features to abs=
tract
>> hdmi dss driver IP agnostic, hdmi dss driver =A0which will now acces=
s
>> generic functions irrespective of underlying IP.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dss_features.c | =A0 20 +++++++++++++++++=
+++
>> =A0drivers/video/omap2/dss/dss_features.h | =A0 =A03 +++
>> =A0drivers/video/omap2/dss/hdmi.c =A0 =A0 =A0 =A0 | =A0 19 +++++++++=
+---------
>> =A0include/video/omapdss.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 23 +=
++++++++++++++++++++++
>> =A0include/video/ti_hdmi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01=
 +
>> =A05 files changed, 57 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/=
omap2/dss/dss_features.c
>> index b63c5f8..4d50b30 100644
>> --- a/drivers/video/omap2/dss/dss_features.c
>> +++ b/drivers/video/omap2/dss/dss_features.c
>> @@ -429,6 +429,26 @@ static const struct omap_dss_features omap4_dss=
_features =3D {
>> =A0 =A0 =A0 .burst_size_unit =3D 16,
>> =A0};
>>
>> +#if defined(CONFIG_OMAP4_DSS_HDMI)
>> +/* HDMI OMAP4 Functions*/
>> +static const struct omap_hdmi_ip_ops omap4_hdmi_functions =3D {
>> +
>> + =A0 =A0 .video_configure =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 ti_hdmi_4x=
xx_basic_configure,
>> + =A0 =A0 .phy_enable =A0 =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0 ti_hdm=
i_4xxx_phy_enable,
>> + =A0 =A0 .phy_disable =A0 =A0 =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 ti_hdm=
i_4xxx_phy_disable,
>> + =A0 =A0 .read_edid =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 ti_h=
dmi_4xxx_read_edid,
>> + =A0 =A0 .pll_enable =A0 =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0 ti_hdm=
i_4xxx_pll_enable,
>> + =A0 =A0 .pll_disable =A0 =A0 =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 ti_hdm=
i_4xxx_pll_disable,
>> + =A0 =A0 .video_enable =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0 ti_hdmi_=
4xxx_wp_video_start,
>> +};
>> +
>> +void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data)
>> +{
>> + =A0 =A0 if (cpu_is_omap44xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 ip_data->ops =3D &omap4_hdmi_functions;
>> +}
>> +#endif
>> +
>> =A0/* Functions returning values related to a DSS feature */
>> =A0int dss_feat_get_num_mgrs(void)
>> =A0{
>> diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/=
omap2/dss/dss_features.h
>> index 4271e96..8b74f69 100644
>> --- a/drivers/video/omap2/dss/dss_features.h
>> +++ b/drivers/video/omap2/dss/dss_features.h
>> @@ -99,4 +99,7 @@ u32 dss_feat_get_burst_size_unit(void); =A0 =A0 =A0=
 =A0 =A0 =A0 /* in bytes */
>> =A0bool dss_has_feature(enum dss_feat_id id);
>> =A0void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start=
, u8 *end);
>> =A0void dss_features_init(void);
>> +#if defined(CONFIG_OMAP4_DSS_HDMI)
>> +void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data);
>> +#endif
>> =A0#endif
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/ds=
s/hdmi.c
>> index 1b989b3..cb54925 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -185,6 +185,7 @@ int hdmi_init_display(struct omap_dss_device *ds=
sdev)
>> =A0{
>> =A0 =A0 =A0 DSSDBG("init_display\n");
>>
>> + =A0 =A0 dss_init_hdmi_ip_ops(&hdmi.hdmi_data);
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> @@ -365,7 +366,7 @@ static void hdmi_read_edid(struct omap_video_tim=
ings *dp)
>> =A0 =A0 =A0 memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
>>
>> =A0 =A0 =A0 if (!hdmi.edid_set)
>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ti_hdmi_4xxx_read_edid(&hdmi.hdmi_=
data, hdmi.edid,
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D hdmi.hdmi_data.ops->read_edid(&hdm=
i.hdmi_data, hdmi.edid,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 HDMI_EDID_MAX_LENGTH);
>> =A0 =A0 =A0 if (!ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!memcmp(hdmi.edid, edid_header, size=
of(edid_header))) {
>> @@ -479,16 +480,16 @@ static int hdmi_power_on(struct omap_dss_devic=
e *dssdev)
>>
>> =A0 =A0 =A0 hdmi_compute_pll(dssdev, phy, &hdmi.hdmi_data.pll_data);
>>
>> - =A0 =A0 ti_hdmi_4xxx_wp_video_start(&hdmi.hdmi_data, 0);
>> + =A0 =A0 hdmi.hdmi_data.ops->video_enable(&hdmi.hdmi_data, 0);
>>
>> =A0 =A0 =A0 /* config the PLL and PHY hdmi_set_pll_pwrfirst */
>> - =A0 =A0 r =3D ti_hdmi_4xxx_pll_enable(&hdmi.hdmi_data);
>> + =A0 =A0 r =3D hdmi.hdmi_data.ops->pll_enable(&hdmi.hdmi_data);
>> =A0 =A0 =A0 if (r) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("Failed to lock PLL\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 r =3D ti_hdmi_4xxx_phy_enable(&hdmi.hdmi_data);
>> + =A0 =A0 r =3D hdmi.hdmi_data.ops->phy_enable(&hdmi.hdmi_data);
>> =A0 =A0 =A0 if (r) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSDBG("Failed to start PHY\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> @@ -496,7 +497,7 @@ static int hdmi_power_on(struct omap_dss_device =
*dssdev)
>>
>> =A0 =A0 =A0 hdmi.hdmi_data.cfg.cm.mode =3D hdmi.mode;
>> =A0 =A0 =A0 hdmi.hdmi_data.cfg.cm.code =3D hdmi.code;
>> - =A0 =A0 ti_hdmi_4xxx_basic_configure(&hdmi.hdmi_data);
>> + =A0 =A0 hdmi.hdmi_data.ops->video_configure(&hdmi.hdmi_data);
>>
>> =A0 =A0 =A0 /* Make selection of HDMI in DSS */
>> =A0 =A0 =A0 dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
>> @@ -518,7 +519,7 @@ static int hdmi_power_on(struct omap_dss_device =
*dssdev)
>>
>> =A0 =A0 =A0 dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
>>
>> - =A0 =A0 ti_hdmi_4xxx_wp_video_start(&hdmi.hdmi_data, 1);
>> + =A0 =A0 hdmi.hdmi_data.ops->video_enable(&hdmi.hdmi_data, 1);
>>
>> =A0 =A0 =A0 return 0;
>> =A0err:
>> @@ -530,9 +531,9 @@ static void hdmi_power_off(struct omap_dss_devic=
e *dssdev)
>> =A0{
>> =A0 =A0 =A0 dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
>>
>> - =A0 =A0 ti_hdmi_4xxx_wp_video_start(&hdmi.hdmi_data, 0);
>> - =A0 =A0 ti_hdmi_4xxx_phy_disable(&hdmi.hdmi_data);
>> - =A0 =A0 ti_hdmi_4xxx_pll_disable(&hdmi.hdmi_data);
>> + =A0 =A0 hdmi.hdmi_data.ops->video_enable(&hdmi.hdmi_data, 0);
>> + =A0 =A0 hdmi.hdmi_data.ops->phy_disable(&hdmi.hdmi_data);
>> + =A0 =A0 hdmi.hdmi_data.ops->pll_disable(&hdmi.hdmi_data);
>> =A0 =A0 =A0 hdmi_runtime_put();
>>
>> =A0 =A0 =A0 hdmi.edid_set =3D 0;
>> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
>> index 9398dd3..c8891d1 100644
>> --- a/include/video/omapdss.h
>> +++ b/include/video/omapdss.h
>> @@ -21,6 +21,9 @@
>> =A0#include <linux/list.h>
>> =A0#include <linux/kobject.h>
>> =A0#include <linux/device.h>
>> +#if defined(CONFIG_OMAP4_DSS_HDMI)
>> +#include <video/ti_hdmi.h>
>> +#endif
>>
>> =A0#define DISPC_IRQ_FRAMEDONE =A0 =A0 =A0 =A0 =A0(1 << 0)
>> =A0#define DISPC_IRQ_VSYNC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1 << 1)
>> @@ -555,6 +558,26 @@ struct omap_dss_driver {
>> =A0 =A0 =A0 u32 (*get_wss)(struct omap_dss_device *dssdev);
>> =A0};
>>
>> +#if defined(CONFIG_OMAP4_DSS_HDMI)
>> +struct omap_hdmi_ip_ops {
>> +
>> + =A0 =A0 void (*video_configure)(struct hdmi_ip_data *ip_data);
>> +
>> + =A0 =A0 int (*phy_enable)(struct hdmi_ip_data *ip_data);
>> +
>> + =A0 =A0 void (*phy_disable)(struct hdmi_ip_data *ip_data);
>> +
>> + =A0 =A0 int (*read_edid)(struct hdmi_ip_data *ip_data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 *pedid, u16 max_length)=
;
>> +
>> + =A0 =A0 int (*pll_enable)(struct hdmi_ip_data *ip_data);
>> +
>> + =A0 =A0 void (*pll_disable)(struct hdmi_ip_data *ip_data);
>> +
>> + =A0 =A0 void (*video_enable)(struct hdmi_ip_data *ip_data, bool st=
art);
>> +};
>> +#endif
>> +
>
> Hmm, I don't think omapdss.h is the right place for this struct.
>
> You've made it omap specific, but similar struct will be needed by ot=
her
> platforms also, right? So would it better be in ti_hdmi.h, and perhap=
s
> called ti_hdmi_ip_ops?
>
> And actually, ti_hdmi.h contains struct hdmi_ip_data, which contains
> pointer to struct omap_hdmi_ip_ops, so it's clear something is wrong
> there.
>
> So either the omap_hdmi_ip_ops should be omapdss internal struct, and=
 it
> shouldn't be in struct hdmi_ip_data, or the ops struct should be gene=
ric
> one in ti_hdmi.h.
>
> Did you consider how the code would look if the function pointers wer=
e
> just included into struct hdmi_ip_data, without any ops struct at all=
?
>
I guess moving it to ti_hdmi.h is a good option.. but i would think
wrapping it in a struct
would look cleaner ?

Thanks and regards,
Mythri.
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
