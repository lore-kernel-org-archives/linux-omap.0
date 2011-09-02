From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 03/10] OMAP4: DSS: HDMI: Use specific HDMI timings structure
Date: Fri, 2 Sep 2011 10:39:07 +0530
Message-ID: <CAP5A+B9E+tsQbXzAcwLEf0f71owbEXO6Kcs4Y0pVDZ_J+L-5ow@mail.gmail.com>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
 <1314598500-24005-2-git-send-email-mythripk@ti.com> <1314598500-24005-3-git-send-email-mythripk@ti.com>
 <1314598500-24005-4-git-send-email-mythripk@ti.com> <1314864861.2169.4.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:47547 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751404Ab1IBFJ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 01:09:28 -0400
Received: by mail-iy0-f171.google.com with SMTP id k10so4253807iag.16
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 22:09:27 -0700 (PDT)
In-Reply-To: <1314864861.2169.4.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, Sep 1, 2011 at 1:44 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Define new HDMI timings structure to replace the OMAP DSS timing str=
ucutre in
>> hdmi.c to have the HDMI include defintion out of DSS.
>
> structure and definition typoed. And the point is not to remove hdmi
> stuff from dss, but dss stuff from hdmi. The generic hdmi driver cann=
ot
> use omap dss specific stuff.
>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/hdmi.c | =A0 22 +++++++++++++++++++---
>> =A0drivers/video/omap2/dss/hdmi.h | =A0 15 ++++++++++++++-
>> =A02 files changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/ds=
s/hdmi.c
>> index 084a47e..ba1ad06 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -537,6 +537,20 @@ static int read_edid(struct hdmi_ip_data *ip_da=
ta, u8 *pedid, u16 max_length)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +static void copy_hdmi_to_dss_timings(struct hdmi_video_timings hdmi=
_timings,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_video_timings =
*timings)
>
> Pass hdmi_timings as a const pointer.
>
Ok.

> =A0Tomi
>
>
>
Thanks and regards,
Mythri
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
