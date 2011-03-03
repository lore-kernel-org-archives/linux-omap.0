From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 2/8] OMAP4 : DSS2 : HDMI: HDMI specific display
 controller and dss change.
Date: Thu, 3 Mar 2011 09:57:42 +0530
Message-ID: <AANLkTikVsqLdRKPwQoeyOMqH+yiLfoGWcjvQDuEO=wYD@mail.gmail.com>
References: <1298988988-28429-1-git-send-email-mythripk@ti.com>
	<1298988988-28429-3-git-send-email-mythripk@ti.com>
	<1298998905.2049.34.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36297 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758123Ab1CCE1n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 23:27:43 -0500
Received: by mail-vw0-f43.google.com with SMTP id 18so711689vws.30
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 20:27:42 -0800 (PST)
In-Reply-To: <1298998905.2049.34.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Tue, Mar 1, 2011 at 10:31 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Tue, 2011-03-01 at 08:16 -0600, K, Mythri P wrote:
>> Adding changes to set gamma table bit for TV interface and function =
to select
>> between VENC and HDMI.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dispc.c | =A0 =A05 +++++
>> =A0drivers/video/omap2/dss/dss.c =A0 | =A0 =A05 +++++
>> =A0drivers/video/omap2/dss/dss.h =A0 | =A0 =A07 +++++++
>> =A03 files changed, 17 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/d=
ss/dispc.c
>> index 69e1e9d..cf385f8 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1224,6 +1224,11 @@ void dispc_enable_zorder(enum omap_plane plan=
e, bool enable)
>> =A0 =A0 =A0 dispc_write_reg(dispc_reg_att[plane], val);
>> =A0}
>>
>> +void dispc_enable_gamma_table(bool enable)
>> +{
>> + =A0 =A0 REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
>> +}
>
> I would separate the gamma function out from this patch. These two
> things are not related in any way.
>
> And I'm not quite happy with this partial gamma implementation, as on=
ly
> the enable function is implemented. At the minimum, put BUG_ON(enable=
);
> there, and a comment that this can currently only be used to disable
> gamma support.
I shall separate these out.
>
>> +
>> =A0static void _dispc_set_vid_color_conv(enum omap_plane plane, bool=
 enable)
>> =A0{
>> =A0 =A0 =A0 u32 val;
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss=
/dss.c
>> index 99de4e1..ca76e68 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -559,6 +559,11 @@ void dss_set_dac_pwrdn_bgz(bool enable)
>> =A0 =A0 =A0 REG_FLD_MOD(DSS_CONTROL, enable, 5, 5); /* DAC Power-Dow=
n Control */
>> =A0}
>>
>> +void dss_select_hdmi_venc(enum dss_hdmi_venc_select hdmi)
>> +{
>> + =A0 =A0 REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15); /* 0x1 for HDMI, 0=
x0 VENC */
>
> That comment is not needed, but you could put "VENC_HDMI_SWITCH" ther=
e
> in the comments.
>
>> +}
>> +
>> =A0static int dss_init(bool skip_init)
>> =A0{
>> =A0 =A0 =A0 int r;
>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss=
/dss.h
>> index b6f27fe..5b5b90c 100644
>> --- a/drivers/video/omap2/dss/dss.h
>> +++ b/drivers/video/omap2/dss/dss.h
>> @@ -123,6 +123,11 @@ enum dss_clk_source {
>> =A0 =A0 =A0 DSS_SRC_DSS1_ALWON_FCLK,
>> =A0};
>>
>> +enum dss_hdmi_venc_select {
>> + =A0 =A0 DSS_VENC_SELECT, =A0 =A0 =A0 =A0/* Select VENC */
>> + =A0 =A0 DSS_HDMI_SELECT, =A0 =A0 =A0 =A0/* Select HDMI */
>> +};
>
> If the integer value of the enum is important, like in this case, you
> need to define the value: DSS_VENC_SELECT =3D 0.
>
> Also, the comments are not needed, they just say the same thing as th=
e
> enum itself.
>
> And only now I realized that this is a clock source switch. The enum =
and
> the function should be named appropriately, for example enum
> dss_tv_clk_out_source. And the sources are TV_CLK and HDMI_M_PCLK, so
> the the enum values should use those as part of their name.
>
ok i shall name them appropriately.
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
