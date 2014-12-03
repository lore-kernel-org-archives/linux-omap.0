From: Jyri Sarha <jsarha@ti.com>
Subject: Re: OMAPDSS: HDMI: Add OMAP5 HDMI support
Date: Wed, 3 Dec 2014 17:05:14 +0200
Message-ID: <547F26AA.4070001@ti.com>
References: <20141203122202.GA7398@mwanda> <547F052F.1040409@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------040002020409060204010803"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41668 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbaLCPFT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Dec 2014 10:05:19 -0500
In-Reply-To: <547F052F.1040409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-omap@vger.kernel.org

--------------040002020409060204010803
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

On 12/03/2014 02:42 PM, Tomi Valkeinen wrote:
> Hi Dan, Jyri,
>
> On 03/12/14 14:22, Dan Carpenter wrote:
>> Hello Tomi Valkeinen,
>>
>> The patch f5bab2229190: "OMAPDSS: HDMI: Add OMAP5 HDMI support" from
>> Mar 13, 2014, leads to the following static checker warning:
>>
>> 	drivers/video/fbdev/omap2/dss/hdmi5_core.c:719 hdmi5_core_audio_config()
>> 	warn: '(3) - (4)' negative one
>>
>> Uh...  This is really weird, I have no idea what this warning is or why
>> it's triggered.  I've even looked at the code which triggers it but that
>> has no documentation.  :P  Still it seems like something worth looking
>> into.
>
> I presume it somehow is caused by this line in the dss.h:
>
> #define FLD_MASK(start, end)	(((1 << ((start) - (end) + 1)) - 1) << (end))
>
> But I don't quite see why the warnings happens. start=3 and end=4 should
> produce valid code there, even if the end result is not what's expected...
>
>> drivers/video/fbdev/omap2/dss/hdmi5_core.c
>>     713          /* PCM audio mode */
>>     714          val = (cfg->iec60958_cfg->status[0] & IEC958_AES0_CON_MODE) >> 6;
>>     715          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(2), val, 6, 4);
>>     716
>>     717          /* Source number */
>>     718          val = cfg->iec60958_cfg->status[2] & IEC958_AES2_CON_SOURCE;
>>     719          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(2), val, 3, 4);
>>                                                                    ^^^^
>> Aren't these reversed?  This seems like an invalid bitfield range.
>
> Good catch! Indeed it's reversed.
>
> Jyri, this is in the hdmi audio side. Can you check it out? Fix is
> trivial, but I'd like to know if it has caused wrong configuration, and
> if it has, why haven't we noticed anything.
>

The bits written there are always zero and hardly significant. The HDMI 
audio still works after the attached patch.

Best regards,
Jyri

ps. One of these days I am going to have to go through these settings 
register by register...

--------------040002020409060204010803
Content-Type: text/x-patch;
	name="0001-OMAPDSS-hdmi5-Fix-bit-field-for-IEC958_AES2_CON_SOUR.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-OMAPDSS-hdmi5-Fix-bit-field-for-IEC958_AES2_CON_SOUR.pa";
	filename*1="tch"

>From 08460e1db02f1babd75b72769e3078462f8e5d81 Mon Sep 17 00:00:00 2001
From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 3 Dec 2014 16:24:06 +0200
Subject: [PATCH] OMAPDSS: hdmi5: Fix bit field for IEC958_AES2_CON_SOURCE

The bit field for IEC958_AES2_CON_SOURCE is bit 3-0 in
HDMI_CORE_FC_AUDSCHNLS2, not imaginary bits 3-4 (reverse order).

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
index a711579..a3cfe3d 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
@@ -716,7 +716,7 @@ static void hdmi5_core_audio_config(struct hdmi_core_data *core,
 
 	/* Source number */
 	val = cfg->iec60958_cfg->status[2] & IEC958_AES2_CON_SOURCE;
-	REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(2), val, 3, 4);
+	REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(2), val, 3, 0);
 
 	/* Channel number right 0  */
 	REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(3), 2, 3, 0);
-- 
1.7.9.5


--------------040002020409060204010803--
