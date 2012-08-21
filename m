From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH V5 1/6] OMAPDSS: DISPC: cleanup cpu_is_xxxx checks
Date: Tue, 21 Aug 2012 16:50:04 +0530
Message-ID: <CAF0AtAthngfxcpm=y61pHMVf00+M7DxekkFamT7=xpx-PNa=Xw@mail.gmail.com>
References: <cover.1343912532.git.cmahapatra@ti.com>
	<cover.1345468541.git.cmahapatra@ti.com>
	<978118e2c23e2da40ceb740665fd19f86810b58a.1345468541.git.cmahapatra@ti.com>
	<1345545102.4085.44.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:44921 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756572Ab2HULUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 07:20:06 -0400
Received: by vbbfn1 with SMTP id fn1so7412164vbb.24
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 04:20:05 -0700 (PDT)
In-Reply-To: <1345545102.4085.44.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, Aug 21, 2012 at 4:01 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-08-20 at 18:52 +0530, Chandrabhanu Mahapatra wrote:
>> All the cpu_is checks have been moved to dispc_init_features function providing
>> a much more generic and cleaner interface. The OMAP version and revision
>> specific functions and data are initialized by dispc_features structure which is
>> local to dispc.c.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>>  drivers/video/omap2/dss/dispc.c |  433 +++++++++++++++++++++++++--------------
>>  1 file changed, 278 insertions(+), 155 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
>> index ff52702..3fad33a 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -81,6 +81,23 @@ struct dispc_irq_stats {
>>       unsigned irqs[32];
>>  };
>>
>> +struct dispc_features {
>> +     int hp_max;
>> +     int vp_max;
>> +     int sw_max;
>> +     int sw_start;
>> +     int fp_start;
>> +     int bp_start;
>
> Here you could use a bit smaller datatype. u16 should probably be more
> than enough.
>

After looking at the values that these variables take I think hp_max,
vp_max and sw_max can be u16 and the rest three sw_start, fp_start and
bp_start can be u8.

>> +static int __init dispc_init_features(struct device *dev)
>> +{
>> +     struct dispc_features *feat = devm_kzalloc(dev, sizeof(*feat),
>> +                                                             GFP_KERNEL);
>> +     if (!feat) {
>> +             dev_err(dev, "Failed to allocate DISPC Features\n");
>> +             return -ENOMEM;
>> +     }
>> +
>> +     if (cpu_is_omap24xx()) {
>> +             memcpy(feat, &omap24xx_dispc_feats, sizeof(*feat));
>> +     } else if (cpu_is_omap34xx()) {
>> +             if (omap_rev() < OMAP3430_REV_ES3_0)
>> +                     memcpy(feat, &omap34xx_rev1_0_dispc_feats,
>> +                                                     sizeof(*feat));
>> +             else
>> +                     memcpy(feat, &omap34xx_rev3_0_dispc_feats,
>> +                                                     sizeof(*feat));
>> +     } else if (cpu_is_omap44xx()) {
>> +             memcpy(feat, &omap44xx_dispc_feats, sizeof(*feat));
>> +     } else {
>> +             return -ENODEV;
>> +     }
>> +
>> +     dispc.feat = feat;
>> +
>> +     return 0;
>> +}
>
> This becomes much cleaner with something like the following (same could
> be used in dss.c also):
>
>         const struct dispc_features *src;
>         struct dispc_features *dst;
>
>         dst = devm_kzalloc(dev, sizeof(*dst), GFP_KERNEL);
>         if (!dsst) {
>                 dev_err(dev, "Failed to allocate DISPC Features\n");
>                 return -ENOMEM;
>         }
>
>         if (cpu_is_omap24xx()) {
>                 src = &omap24xx_dispc_feats;
>         } else if (cpu_is_omap34xx()) {
>                 if (omap_rev() < OMAP3430_REV_ES3_0)
>                         src = &omap34xx_rev1_0_dispc_feats;
>                 else
>                         src = &omap34xx_rev3_0_dispc_feats;
>         } else if (cpu_is_omap44xx()) {
>                 src = &omap44xx_dispc_feats;
>         } else {
>                 return -ENODEV;
>         }
>
>         memcpy(dst, src, sizeof(*dst));
>
>         dispc.feat = dst;
>
>  Tomi
>

ok, looks cleaner.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
