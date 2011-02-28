From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 3/8] OMAP4 : DSS : HDMI: HDMI specific display controller
 and dss change.
Date: Mon, 28 Feb 2011 11:51:20 +0530
Message-ID: <AANLkTi=1xrEzjVA9Z+a2_ZXmhgQTr=08saosGWWdhXaB@mail.gmail.com>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	<1298643715-21540-4-git-send-email-mythripk@ti.com>
	<1298798583.1977.13.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:45085 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752600Ab1B1GVW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:21:22 -0500
Received: by mail-vw0-f51.google.com with SMTP id 18so2991094vws.38
        for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 22:21:21 -0800 (PST)
In-Reply-To: <1298798583.1977.13.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Sun, Feb 27, 2011 at 2:53 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-02-25 at 08:21 -0600, K, Mythri P wrote:
>> Adding changes to set gamma table bit for TV interface and function =
to select
>> between VENC and HDMI.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dispc.c | =A0 =A05 +++++
>> =A0drivers/video/omap2/dss/dss.c =A0 | =A0 =A07 +++++++
>> =A0drivers/video/omap2/dss/dss.h =A0 | =A0 =A02 ++
>> =A03 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/d=
ss/dispc.c
>> index 6d9bb17..16f1106 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1213,6 +1213,11 @@ void dispc_enable_zorder(enum omap_plane plan=
e, bool enable)
>> =A0 =A0 =A0 dispc_write_reg(dispc_reg_att[plane], val);
>> =A0}
>>
>> +void dispc_enable_gamma_table(bool enable)
>> +{
>> + =A0 =A0 REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
>> +}
>> +
>> =A0static void _dispc_set_vid_color_conv(enum omap_plane plane, bool=
 enable)
>> =A0{
>> =A0 =A0 =A0 u32 val;
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss=
/dss.c
>> index 99de4e1..127d42e 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -559,6 +559,13 @@ void dss_set_dac_pwrdn_bgz(bool enable)
>> =A0 =A0 =A0 REG_FLD_MOD(DSS_CONTROL, enable, 5, 5); /* DAC Power-Dow=
n Control */
>> =A0}
>>
>> +void dss_select_hdmi_venc(bool hdmi)
>> +{
>> + =A0 =A0 REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15); /* 0x1 for HDMI, 0=
x0 VENC */
>> + =A0 =A0 if (hdmi)
>> + =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(DSS_CONTROL, 0, 9, 8);
>> +}
>
> bool argument for this function is very confusing. Which one is true?
> Perhaps this could use an enum.
I have added a comment , 1 is for HDMI and 0 for VENC.
>
> I've tried to keep the habit of having the name of the register field=
 in
> comments to make the code easier to read. For example, /*
> VENC_HDMI_SWITCH */ for the bit 15.
I can add this.
>
> The bits 8 and 9 are FCK_CLK_SWITCH. Why do you set it here? Looks
> rather dangerous to change the clock source like that.
>
This is to select what would be the clock source to DISPC, HDMI would
need the DISPC
to run at the rate of pixel clock (TMDS if deep color is set ) required=
 by HDMI.
Where as DSI does not have any such constraint( correct me if i am wron=
g).
I suppose we can have a patch to select the correct clock source to
DISPC dynamically
based on what panels are connected later on ?

> =A0Tomi
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
