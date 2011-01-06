From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v3 09/17] OMAP2,3: DSS2: Move clocks from core driver to
 dss driver
Date: Thu, 6 Jan 2011 15:10:56 +0530
Message-ID: <AANLkTikeJX2qnhf-AmiDcb_9Dkmc1pQAFcj=WF9xo5R1@mail.gmail.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
 <1294059069-26737-10-git-send-email-svadivu@ti.com> <1294241755.14254.142.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:48992 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752097Ab1AFJlR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jan 2011 04:41:17 -0500
Received: by mail-bw0-f47.google.com with SMTP id 10so15584304bwz.6
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 01:41:16 -0800 (PST)
In-Reply-To: <1294241755.14254.142.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Guruswamy Senthilvadivu <svadivu@ti.com>, paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org

Hi Tomi,

On Wed, Jan 5, 2011 at 9:05 PM, Tomi Valkeinen <tomi.valkeinen@nokia.co=
m> wrote:
> On Mon, 2011-01-03 at 18:21 +0530, ext Guruswamy Senthilvadivu wrote:
>> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>>
>> clks are moved to dss platform driver. =A0clk_get/put APIs use dss d=
evice instead
>> of core platform device. So the device name is changed from omap_dis=
play to
>> omap_dss in 2420, 2430, 3xxx clock database files. Now teh core driv=
er
>> "omap_display" only takes care of panel registration with the custom=
 bus.
>> dss driver would take care of the clocks needed by DISPC, RFBI, DSI,=
 VENC.
>>
>> TODO: =A0The clock content would be adapted to omap_hwmod in a seper=
ate series.
>>
>> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>
> <snip>
>
>> @@ -508,14 +192,7 @@ static int omap_dss_probe(struct platform_devic=
e *pdev)
>> =A0 =A0 =A0 dss_init_overlay_managers(pdev);
>> =A0 =A0 =A0 dss_init_overlays(pdev);
>>
>> - =A0 =A0 r =3D dss_get_clocks();
>> - =A0 =A0 if (r)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto err_clocks;
>> -
>> - =A0 =A0 dss_clk_enable_all_no_ctx();
>> -
>> - =A0 =A0 core.ctx_id =3D dss_get_ctx_id();
>> - =A0 =A0 DSSDBG("initial ctx id %u\n", core.ctx_id);
>> + =A0 =A0 dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
>>
>> =A0#ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
>> =A0 =A0 =A0 /* DISPC_CONTROL */
>> @@ -589,7 +266,7 @@ static int omap_dss_probe(struct platform_device=
 *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->default_device =3D=
 dssdev;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 dss_clk_disable_all();
>> + =A0 =A0 dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
>
> Why are the calls dss_clk_enable_all_no_ctx() and dss_clk_disable_all=
()
> changed?
This came as an after-effect of moving all clk related stuff to dss.c;
I think the idea is that all the new DSS IP platform drivers should
use only the exposed clock mgmt APIs [dss_clk_enable() /
dss_clk_disable()].
However, you are right; all the required clocks might not be getting
enabled / disabled as required.
I can (re)create the static dss_clk_disable_all() /
dss_clk_enable_all_no_ctx() locally inside core.c - do you think
that's ok, or should I export these functions too from dss.c?
>
>> =A0/* DSS HW IP initialisation */
>> =A0static int omap_dsshw_probe(struct platform_device *pdev)
>> =A0{
>> - =A0 =A0 return 0;
>> + =A0 =A0 int r;
>> +
>> + =A0 =A0 dss.pdev =3D pdev;
>> +
>> + =A0 =A0 r =3D dss_get_clocks();
>> + =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_clocks;
>> +
>> + =A0 =A0 dss_clk_enable_all_no_ctx();
>> +
>> + =A0 =A0 dss.ctx_id =3D dss_get_ctx_id();
>> + =A0 =A0 DSSDBG("initial ctx id %u\n", dss.ctx_id);
>> +
>> + =A0 =A0 dss_clk_disable_all_no_ctx();
>
> I don't think clock enable/disable are needed here. dss_get_ctx_id()
> should work fine without DSS's clocks.
you're right; this is not required. will remove.

Best regards,
~Sumit.
>
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
