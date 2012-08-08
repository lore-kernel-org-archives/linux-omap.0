From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: cleanup cpu_is_xxxx checks
Date: Wed, 8 Aug 2012 18:31:41 +0530
Message-ID: <CAF0AtAv3uuS_GDuYEk4mpUKieZqqBnLUpRcLBx0M4zjbsSq2Nw@mail.gmail.com>
References: <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
	<1344425874-28222-1-git-send-email-cmahapatra@ti.com>
	<1344429360.4932.58.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:44821 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757805Ab2HHNBn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 09:01:43 -0400
Received: by yhjj63 with SMTP id j63so833491yhj.37
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 06:01:42 -0700 (PDT)
In-Reply-To: <1344429360.4932.58.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, Aug 8, 2012 at 6:06 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Wed, 2012-08-08 at 17:07 +0530, Chandrabhanu Mahapatra wrote:
>> All the cpu_is checks have been moved to dispc_init_features function providing
>> a much more generic and cleaner interface. The OMAP version and revision
>> specific functions are initialized by dispc_features structure local to dispc.c.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>>  drivers/video/omap2/dss/dispc.c |  476 ++++++++++++++++++++++++++-------------
>>  1 file changed, 315 insertions(+), 161 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
>> index 5b289c5..7e0b080 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -75,12 +75,60 @@ enum omap_burst_size {
>>  #define REG_FLD_MOD(idx, val, start, end)                            \
>>       dispc_write_reg(idx, FLD_MOD(dispc_read_reg(idx), val, start, end))
>>
>> +static int dispc_ovl_calc_scaling_24xx(enum omap_channel channel,
>> +     const struct omap_video_timings *mgr_timings, u16 width, u16 height,
>> +     u16 out_width, u16 out_height, enum omap_color_mode color_mode,
>> +     bool *five_taps, int *x_predecim, int *y_predecim, int *decim_x,
>> +     int *decim_y, u16 pos_x, unsigned long *core_clk);
>> +static int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
>> +     const struct omap_video_timings *mgr_timings, u16 width, u16 height,
>> +     u16 out_width, u16 out_height,  enum omap_color_mode color_mode,
>> +     bool *five_taps, int *x_predecim, int *y_predecim, int *decim_x,
>> +     int *decim_y, u16 pos_x, unsigned long *core_clk);
>> +static int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
>> +     const struct omap_video_timings *mgr_timings, u16 width, u16 height,
>> +     u16 out_width, u16 out_height,  enum omap_color_mode color_mode,
>> +     bool *five_taps, int *x_predecim, int *y_predecim, int *decim_x,
>> +     int *decim_y, u16 pos_x, unsigned long *core_clk);
>> +
>> +static unsigned long calc_core_clk_24xx(enum omap_channel channel, u16 width,
>> +             u16 height, u16 out_width, u16 out_height);
>> +static unsigned long calc_core_clk_34xx(enum omap_channel channel, u16 width,
>> +             u16 height, u16 out_width, u16 out_height);
>> +static unsigned long calc_core_clk_44xx(enum omap_channel channel, u16 width,
>> +             u16 height, u16 out_width, u16 out_height);
>> +
>> +static bool _dispc_lcd_timings_ok_24xx(int hsw, int hfp, int hbp,
>> +             int vsw, int vfp, int vbp);
>> +static bool _dispc_lcd_timings_ok_44xx(int hsw, int hfp, int hbp,
>> +             int vsw, int vfp, int vbp);
>> +
>> +static void _dispc_mgr_set_lcd_timings_hv_24xx(enum omap_channel channel,
>> +             int hsw, int hfp, int hbp, int vsw, int vfp, int vbp);
>> +static void _dispc_mgr_set_lcd_timings_hv_44xx(enum omap_channel channel,
>> +             int hsw, int hfp, int hbp, int vsw, int vfp, int vbp);
>
> While it's nice to have the initialization of struct dispc_features in
> the beginning of dispc.c, it requires the above prototypes. And in the
> future we may require more. For that reason I think it's better to
> initialize the dispc_features at the end of dispc.c, just above
> dispc_init_features(). This would be kinda similar to how drivers often
> initialize their ops.
>

Yes, this sounds good, but I was just following general order of
structure and function declarations, structures initializations
followed by functions.

>> +static const struct dispc_features omap2_dispc_features = {
>> +     .calc_scaling           =       dispc_ovl_calc_scaling_24xx,
>> +     .calc_core_clk          =       calc_core_clk_24xx,
>> +     .lcd_timings_ok         =       _dispc_lcd_timings_ok_24xx,
>> +     .set_lcd_timings_hv     =       _dispc_mgr_set_lcd_timings_hv_24xx,
>> +};
>> +
>> +static const struct dispc_features omap3_2_1_dispc_features = {
>> +     .calc_scaling           =       dispc_ovl_calc_scaling_34xx,
>> +     .calc_core_clk          =       calc_core_clk_34xx,
>> +     .lcd_timings_ok         =       _dispc_lcd_timings_ok_24xx,
>> +     .set_lcd_timings_hv     =       _dispc_mgr_set_lcd_timings_hv_24xx,
>> +};
>> +
>> +static const struct dispc_features omap3_3_0_dispc_features = {
>> +     .calc_scaling           =       dispc_ovl_calc_scaling_34xx,
>> +     .calc_core_clk          =       calc_core_clk_34xx,
>> +     .lcd_timings_ok         =       _dispc_lcd_timings_ok_44xx,
>> +     .set_lcd_timings_hv     =       _dispc_mgr_set_lcd_timings_hv_44xx,
>> +};
>> +
>> +static const struct dispc_features omap4_dispc_features = {
>> +     .calc_scaling           =       dispc_ovl_calc_scaling_44xx,
>> +     .calc_core_clk          =       calc_core_clk_44xx,
>> +     .lcd_timings_ok         =       _dispc_lcd_timings_ok_44xx,
>> +     .set_lcd_timings_hv     =       _dispc_mgr_set_lcd_timings_hv_44xx,
>> +};
>
> During runtime we only require one of these, others can be discarded.
> This can be accomplished with the combination of "__initdata" for these,
> and "__init" for dispc_init_features().
>

The same also applies for all structures in dss_features.c. Just a
thought that __init and __initdata should have also been used there.

> However, because even the one we need will be discarded, we need to copy
> the values. This could be done either by having the dispc_features
> struct inside dispc struct (instead of a pointer), or allocating memory
> for it with devm_kzalloc(). The latter allows us to keep it const, but
> I'm not sure which approach is better (if either).
>

The latter approach seems better as we need to keep it const. I will
try out both anyways.

>> -static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
>> +static bool _dispc_lcd_timings_ok_24xx(int hsw, int hfp, int hbp,
>>               int vsw, int vfp, int vbp)
>>  {
>> -     if (cpu_is_omap24xx() || omap_rev() < OMAP3430_REV_ES3_0) {
>> -             if (hsw < 1 || hsw > 64 ||
>> -                             hfp < 1 || hfp > 256 ||
>> -                             hbp < 1 || hbp > 256 ||
>> -                             vsw < 1 || vsw > 64 ||
>> -                             vfp < 0 || vfp > 255 ||
>> -                             vbp < 0 || vbp > 255)
>> -                     return false;
>> -     } else {
>> -             if (hsw < 1 || hsw > 256 ||
>> -                             hfp < 1 || hfp > 4096 ||
>> -                             hbp < 1 || hbp > 4096 ||
>> -                             vsw < 1 || vsw > 256 ||
>> -                             vfp < 0 || vfp > 4095 ||
>> -                             vbp < 0 || vbp > 4095)
>> -                     return false;
>> -     }
>> -
>> +     if (hsw < 1 || hsw > 64 ||
>> +                     hfp < 1 || hfp > 256 ||
>> +                     hbp < 1 || hbp > 256 ||
>> +                     vsw < 1 || vsw > 64  ||
>> +                     vfp < 0 || vfp > 255 ||
>> +                     vbp < 0 || vbp > 255)
>> +             return false;
>> +     return true;
>> +}
>> +static bool _dispc_lcd_timings_ok_44xx(int hsw, int hfp, int hbp,
>> +             int vsw, int vfp, int vbp)
>> +{
>> +     if (hsw < 1 || hsw > 256 ||
>> +                     hfp < 1  || hfp > 4096 ||
>> +                     hbp < 1  || hbp > 4096 ||
>> +                     vsw < 1  || vsw > 256  ||
>> +                     vfp < 0  || vfp > 4095 ||
>> +                     vbp < 0  || vbp > 4095)
>> +             return false;
>>       return true;
>>  }
>
> I think we should use separate functions only when the code is
> different. Here the code is the same, we just use different max values.
>
> So instead of these functions, I suggest to add those max values into
> struct dispc_features.

Ok.

>
>> @@ -2633,7 +2757,8 @@ bool dispc_mgr_timings_ok(enum omap_channel channel,
>>       timings_ok = _dispc_mgr_size_ok(timings->x_res, timings->y_res);
>>
>>       if (dss_mgr_is_lcd(channel))
>> -             timings_ok =  timings_ok && _dispc_lcd_timings_ok(timings->hsw,
>> +             timings_ok =  timings_ok &&
>> +                     dispc.feat->lcd_timings_ok(timings->hsw,
>>                                               timings->hfp, timings->hbp,
>>                                               timings->vsw, timings->vfp,
>>                                               timings->vbp);
>> @@ -2641,6 +2766,34 @@ bool dispc_mgr_timings_ok(enum omap_channel channel,
>>       return timings_ok;
>>  }
>>
>> +static void _dispc_mgr_set_lcd_timings_hv_24xx(enum omap_channel channel,
>> +             int hsw, int hfp, int hbp, int vsw, int vfp, int vbp)
>> +{
>> +     u32 timing_h, timing_v;
>> +
>> +     timing_h = FLD_VAL(hsw-1, 5, 0) | FLD_VAL(hfp-1, 15, 8) |
>> +                     FLD_VAL(hbp-1, 27, 20);
>> +     timing_v = FLD_VAL(vsw-1, 5, 0) | FLD_VAL(vfp, 15, 8) |
>> +                     FLD_VAL(vbp, 27, 20);
>> +
>> +     dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
>> +     dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
>> +}
>> +
>> +static void _dispc_mgr_set_lcd_timings_hv_44xx(enum omap_channel channel,
>> +             int hsw, int hfp, int hbp, int vsw, int vfp, int vbp)
>> +{
>> +     u32 timing_h, timing_v;
>> +
>> +     timing_h = FLD_VAL(hsw-1, 7, 0) | FLD_VAL(hfp-1, 19, 8) |
>> +                     FLD_VAL(hbp-1, 31, 20);
>> +     timing_v = FLD_VAL(vsw-1, 7, 0) | FLD_VAL(vfp, 19, 8) |
>> +                     FLD_VAL(vbp, 31, 20);
>> +
>> +     dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
>> +     dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
>> +}
>
> Same thing here. The code is the same, only the bit fields are larger.
>
>  Tomi
>
ok


-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
