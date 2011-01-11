From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v5 10/17] OMAP2,3: DSS2: Move clocks from core driver to
 dss driver
Date: Tue, 11 Jan 2011 10:46:17 +0530
Message-ID: <AANLkTi=rDxM6ttpn4vD2eNZd--SodUvcRkmih_KBsdAF@mail.gmail.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
 <1294399551-10457-11-git-send-email-sumit.semwal@ti.com> <alpine.DEB.2.00.1101101657050.5731@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35998 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750888Ab1AKFQj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jan 2011 00:16:39 -0500
Received: by bwg12 with SMTP id 12so14750835bwg.26
        for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 21:16:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101101657050.5731@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tomi.valkeinen@nokia.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Hi Paul,

On Tue, Jan 11, 2011 at 5:29 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Fri, 7 Jan 2011, Sumit Semwal wrote:
>
>> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>>
>> All clock management is moved to dss platform driver. clk_get/put AP=
Is use
>> dss device instead of core platform device.
>>
>> Hwmod adaptation design requires each of the DSS HW IP to be a platf=
orm driver.
>> So the device name is changed from omap_display to omap_dss in 2420,=
 2430,
>> 3xxx clock database files. Now the core driver "omap_display" only t=
akes care
>> of panel registration with the custom bus.
>> core driver also uses the clk_enable() / clk_disable() APIs exposed =
by DSS for
>> clock management.
>> DSS driver would do clock management of clocks needed by DISPC, RFBI=
, DSI, VENC
>>
>> TODO: =A0The clock content would be adapted to omap_hwmod in a seper=
ate series.
>>
>> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/clock2420_data.c | =A0 =A08 +-
>> =A0arch/arm/mach-omap2/clock2430_data.c | =A0 =A08 +-
>> =A0arch/arm/mach-omap2/clock3xxx_data.c | =A0 14 +-
>
> ...
>
>>
>> diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-om=
ap2/clock2420_data.c
>> index a220820..7a56c67 100644
>> --- a/arch/arm/mach-omap2/clock2420_data.c
>> +++ b/arch/arm/mach-omap2/clock2420_data.c
>> @@ -1786,10 +1786,10 @@ static struct omap_clk omap2420_clks[] =3D {
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gfx_2d_fck", =A0 &gfx_2d_fck, =A0=
 =A0CK_242X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gfx_ick", =A0 =A0 =A0&gfx_ick, =A0=
 =A0 =A0 CK_242X),
>> =A0 =A0 =A0 /* DSS domain clocks */
>> - =A0 =A0 CLK("omap_display", =A0 =A0 "ick", =A0 =A0 =A0 =A0 =A0&dss=
_ick, =A0 =A0 =A0 CK_242X),
>> - =A0 =A0 CLK("omap_display", =A0 =A0 "dss1_fck", =A0 =A0 &dss1_fck,=
 =A0 =A0 =A0CK_242X),
>> - =A0 =A0 CLK("omap_display", =A0 =A0 "dss2_fck", =A0 =A0 &dss2_fck,=
 =A0 =A0 =A0CK_242X),
>> - =A0 =A0 CLK("omap_display", =A0 =A0 "tv_fck", =A0 =A0 =A0 &dss_54m=
_fck, =A0 CK_242X),
>> + =A0 =A0 CLK("omap_dss", "ick", =A0 =A0 =A0 =A0 =A0&dss_ick, =A0 =A0=
 =A0 CK_242X),
>> + =A0 =A0 CLK("omap_dss", "dss1_fck", =A0 =A0 &dss1_fck, =A0 =A0 =A0=
CK_242X),
>> + =A0 =A0 CLK("omap_dss", "dss2_fck", =A0 =A0 &dss2_fck, =A0 =A0 =A0=
CK_242X),
>> + =A0 =A0 CLK("omap_dss", "tv_fck", =A0 =A0 =A0 &dss_54m_fck, =A0 CK=
_242X),
>> =A0 =A0 =A0 /* L3 domain clocks */
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "core_l3_ck", =A0 &core_l3_ck, =A0=
 =A0CK_242X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "ssi_fck", =A0 =A0 =A0&ssi_ssr_sst=
_fck, CK_242X),
>
> It would be nice if you could figure out some way to combine or
> restructure these changes with the patch 4 changes, to avoid changing
> these from "omapdss" to "omap_display" then to "omap_dss".
I thought, and realized that this is done to make sure functionality's
not broken after each patch; here's the logic.

patch 4 is the first step in re-defining role of core.c - this DSS
file should not handle ALL clocks / regulators, but just some related
to displays, hence the move to device name 'omap_display'. At this
point, since all DSS clock handling is still in the same file, we
changed the controlling device name also to 'omap_display'.
patch 10 then is the second step, when all clock handling is moved to
dss.c, and as a result, device_name for all clocks gets changed to
'omap_dss'; for display regulator supplies [like DVI], still the
controlling device is 'omap_display'.
>
> In any case,
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
Thanks for the Ack! :)
~Sumit.
>
>
>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
