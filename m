From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 2/2] OMAPDSS: HDMI: Disable HDMI DDC internal pull up
Date: Mon, 14 Nov 2011 09:36:50 +0530
Message-ID: <CAP5A+B-J03FJgNFST0YF8z0GPFqBw_X_8XbqbSURDJb-4Mb9Rg@mail.gmail.com>
References: <1321016900-1714-1-git-send-email-mythripk@ti.com>
 <1321016900-1714-2-git-send-email-mythripk@ti.com> <1321016900-1714-3-git-send-email-mythripk@ti.com>
 <1321016900-1714-4-git-send-email-mythripk@ti.com> <20111111172200.GG31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:33893 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752738Ab1KNEHM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 13 Nov 2011 23:07:12 -0500
Received: by ywp27 with SMTP id 27so4427941ywp.38
        for <linux-omap@vger.kernel.org>; Sun, 13 Nov 2011 20:07:11 -0800 (PST)
In-Reply-To: <20111111172200.GG31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>

Hi Tony,

On Fri, Nov 11, 2011 at 10:52 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * mythripk@ti.com <mythripk@ti.com> [111111 04:41]:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Disables the internal pull resistor for SDA and SCL enabled by
>> default as there are expernal pull up's in 4460 and 4430 ES2.3,
>> It is done to avoid the EDID read failure.
>>
>> Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@linaro.org=
>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0| =A0 12 +++++++++++-
>> =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 13 ++++++++++++-
>> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0| =A0 17 +++++++=
+++++++---
>> =A0include/video/omapdss.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 +-
>> =A04 files changed, 38 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-oma=
p2/board-4430sdp.c
>> index 4a519a3..91d3742 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -826,7 +826,17 @@ static void omap_4430sdp_display_init(void)
>> =A0 =A0 =A0 sdp4430_lcd_init();
>> =A0 =A0 =A0 sdp4430_picodlp_init();
>> =A0 =A0 =A0 omap_display_init(&sdp4430_dss_data);
>> - =A0 =A0 omap_hdmi_enable_pads();
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
>> + =A0 =A0 =A0* HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
>> + =A0 =A0 =A0* internal pull up resistor - This is a change needed i=
n
>> + =A0 =A0 =A0* OMAP4460 and OMAP4430 ES2.3 as the external pull up
>> + =A0 =A0 =A0* are present. This is needed to avoid EDID read failur=
e.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2)=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hdmi_enable_pads(1);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hdmi_enable_pads(0);
>> =A0}
>
> If you now have omap_hdmi_init(), then you can just pass it board
> specific flags like OMAP_HDMI_EXTERNAL_PULL. The generic init functio=
n
> will make it easier to move things over to DT also.
>
Thanks, sure will take care of this.

Thanks and regards,
Mythri.

> Regards,
>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
