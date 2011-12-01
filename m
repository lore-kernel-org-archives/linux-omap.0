From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [PATCH v2 05/11] OMAP4: Add base addresses for ISS
Date: Thu, 1 Dec 2011 11:30:14 -0600
Message-ID: <CAKnK67TR5KJ8U4AeDuF7AzxDwOPF7X1ak7mn0tBhrROwu8H6_g@mail.gmail.com>
References: <1322698500-29924-1-git-send-email-saaguirre@ti.com>
 <1322698500-29924-6-git-send-email-saaguirre@ti.com> <201112011824.49591.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201112011824.49591.laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, sakari.ailus@iki.fi
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

Thanks for the review.

On Thu, Dec 1, 2011 at 11:24 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Sergio,
>
> On Thursday 01 December 2011 01:14:54 Sergio Aguirre wrote:
>> NOTE: This isn't the whole list of features that the
>> ISS supports, but the only ones supported at the moment.
>>
>> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 32
>> ++++++++++++++++++++++++++++ arch/arm/plat-omap/include/plat/omap44x=
x.h |
>> =A0 9 +++++++
>> =A02 files changed, 41 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/dev=
ices.c
>> index c15cfad..b48aeea 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -32,6 +32,7 @@
>> =A0#include <plat/omap_hwmod.h>
>> =A0#include <plat/omap_device.h>
>> =A0#include <plat/omap4-keypad.h>
>> +#include <plat/omap4-iss.h>
>
> I try to keep headers sorted alphabetically when possible, but that m=
ight just
> be me.

No problem. I can change it.

>
>>
>> =A0#include "mux.h"
>> =A0#include "control.h"
>> @@ -217,6 +218,37 @@ int omap3_init_camera(struct isp_platform_data =
*pdata)
>> =A0 =A0 =A0 return platform_device_register(&omap3isp_device);
>> =A0}
>>
>> +int omap4_init_camera(struct iss_platform_data *pdata, struct
>> omap_board_data *bdata)
>> +{
>> + =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 struct omap_hwmod *oh;
>> + =A0 =A0 struct iss_platform_data *omap4iss_pdata;
>> + =A0 =A0 char *oh_name =3D "iss";
>> + =A0 =A0 char *name =3D "omap4iss";
>
> Would const char or static const char help the compiler putting the s=
trings to
> a read-only section ?

Right. Will fix.

>
>> + =A0 =A0 unsigned int id =3D -1;
>> +
>> + =A0 =A0 oh =3D omap_hwmod_lookup(oh_name);
>> + =A0 =A0 if (!oh) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Could not look up %s\n", oh_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 omap4iss_pdata =3D pdata;
>> +
>> + =A0 =A0 pdev =3D omap_device_build(name, id, oh, omap4iss_pdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct iss_platform=
_data), NULL, 0, 0);
>
> This is the only location where id is used, maybe you could pass -1 d=
irectly
> to the function ?

Ditto.

Thanks and regards,
Sergio

>
>> +
>> + =A0 =A0 if (IS_ERR(pdev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "Can't build omap_device for %s:%s=
=2E\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 name, oh->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(pdev);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 oh->mux =3D omap_hwmod_mux_init(bdata->pads, bdata->pads_c=
nt);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> =A0static inline void omap_init_camera(void)
>> =A0{
>> =A0#if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MOD=
ULE)
>> diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h
>> b/arch/arm/plat-omap/include/plat/omap44xx.h index ea2b8a6..31432aa =
100644
>> --- a/arch/arm/plat-omap/include/plat/omap44xx.h
>> +++ b/arch/arm/plat-omap/include/plat/omap44xx.h
>> @@ -49,6 +49,15 @@
>> =A0#define OMAP44XX_MAILBOX_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(L4_=
44XX_BASE + 0xF4000)
>> =A0#define OMAP44XX_HSUSB_OTG_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0(L4_44=
XX_BASE + 0xAB000)
>>
>> +#define OMAP44XX_ISS_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x=
52000000
>> +#define OMAP44XX_ISS_TOP_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(OMAP44XX_ISS_BASE + 0x0)
>> +#define OMAP44XX_ISS_CSI2_A_REGS1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
(OMAP44XX_ISS_BASE + 0x1000)
>> +#define OMAP44XX_ISS_CAMERARX_CORE1_BASE =A0 =A0 (OMAP44XX_ISS_BASE=
 + 0x1170)
>> +
>> +#define OMAP44XX_ISS_TOP_END =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OMAP4=
4XX_ISS_TOP_BASE + 256 - 1)
>> +#define OMAP44XX_ISS_CSI2_A_REGS1_END =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(OMAP44XX_ISS_CSI2_A_REGS1_BASE +
>> 368 - 1) +#define
>> OMAP44XX_ISS_CAMERARX_CORE1_END =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OMAP44X=
X_ISS_CAMERARX_CORE1_BASE + 32 -
>> 1) +
>> =A0#define OMAP4_MMU1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x55082000
>> =A0#define OMAP4_MMU2_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x4A066000
>
> --
> Regards,
>
> Laurent Pinchart
