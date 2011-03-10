From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v4 3/9] OMAP4 : DSS2 : HDMI: HDMI dispc gamma table disable.
Date: Thu, 10 Mar 2011 11:25:10 +0530
Message-ID: <AANLkTi=bwx1Ti6YKf3dri1-sFhUMkGaiPd2asagmvQDk@mail.gmail.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	<1299671118-20839-2-git-send-email-mythripk@ti.com>
	<1299671118-20839-3-git-send-email-mythripk@ti.com>
	<1299671118-20839-4-git-send-email-mythripk@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C192274@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:39405 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750854Ab1CJFzM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 00:55:12 -0500
Received: by vxb39 with SMTP id 39so1620371vxb.15
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 21:55:11 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C192274@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Sanjeev,

On Wed, Mar 9, 2011 at 8:19 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of K, Mythri P
>> Sent: Wednesday, March 09, 2011 5:15 PM
>> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
>> Cc: K, Mythri P
>> Subject: [PATCH v4 3/9] OMAP4 : DSS2 : HDMI: HDMI dispc gamma table
>> disable.
> [sp] HDMI seems repetitive in the subject in this and some of the sub=
sequent
> =A0 =A0 Patches.
>>
>> Adding changes to set gamma table bit for TV interface to make sure =
it is
>> disabled
>
> [sp] Is this bit expected to be "enabled" by default? If no, how can/=
would
> =A0 =A0 this bit get enabled.
>
> =A0 =A0 The subject and description of the patch doesn't match the co=
ntents.
> =A0 =A0 The patch is adding a function that can *both* enable/disable=
 gamma
> =A0 =A0 table - not just disable.
>We have seen several examples of the reset bit being changed across Si=
licon versions ,
So this is to set the gamma enable to 0 Effectively a disable., so i
have added a comment
that this still needs to add enable functionality.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dispc.c | =A0 10 ++++++++++
>> =A0drivers/video/omap2/dss/dss.h =A0 | =A0 =A01 +
>> =A02 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c
>> b/drivers/video/omap2/dss/dispc.c
>> index 4a368c4..0defe16 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1008,6 +1008,16 @@ void dispc_set_burst_size(enum omap_plane pla=
ne,
>> =A0 =A0 =A0 enable_clocks(0);
>> =A0}
>>
>> +void dispc_enable_gamma_table(bool enable)
>> +{
>> + =A0 =A0 /* This is partially implemented to support only
>> + =A0 =A0 =A0* =A0disabling of the gamma table.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 BUG_ON(enable);
> [sp] Is BUG_ON really needed. Can't this be a WARN or equiv?
>
>> +
>> + =A0 =A0 REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
>
> [sp] I don't understand HDMI much, but if enabling gamma causes BUG_O=
N,
> =A0 =A0 then why would we need implementation to disable it.
>
> =A0 =A0 Instead, shouldn't the function be empty - if it can't be avo=
ided
> =A0 =A0 altogether?
>
>> +}
>> +
>> =A0static void _dispc_set_vid_color_conv(enum omap_plane plane, bool=
 enable)
>> =A0{
>> =A0 =A0 =A0 u32 val;
>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss=
/dss.h
>> index 29f31fd..008cbf4 100644
>> --- a/drivers/video/omap2/dss/dss.h
>> +++ b/drivers/video/omap2/dss/dss.h
>> @@ -363,6 +363,7 @@ void dispc_set_plane_size(enum omap_plane plane,=
 u16
>> width, u16 height);
>> =A0void dispc_set_channel_out(enum omap_plane plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum omap_channel channel_out);
>>
>> +void dispc_enable_gamma_table(bool enable);
>
> [sp] Is this patch really standalone? I suggest merging it with the p=
atch
> =A0 =A0 where the API is actually used.
>
> =A0 =A0 In effect, nothing gets disabled in this patch.
>
>> =A0int dispc_setup_plane(enum omap_plane plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 paddr, u16 screen_width,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 pos_x, u16 pos_y,
>> --
>> 1.5.6.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
