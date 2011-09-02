From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 04/10] OMAP4: DSS: HDMI: Move the common header file
Date: Fri, 2 Sep 2011 10:45:55 +0530
Message-ID: <CAP5A+B8j=6+a2m=Lpf0-G-arO9q2R_286=mHEv52qm4FiyWnZg@mail.gmail.com>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
 <1314598500-24005-2-git-send-email-mythripk@ti.com> <1314598500-24005-3-git-send-email-mythripk@ti.com>
 <1314598500-24005-4-git-send-email-mythripk@ti.com> <1314598500-24005-5-git-send-email-mythripk@ti.com>
 <1314867624.2169.21.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:53928 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904Ab1IBFQQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 01:16:16 -0400
Received: by mail-iy0-f172.google.com with SMTP id c1so2778767iak.3
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 22:16:15 -0700 (PDT)
In-Reply-To: <1314867624.2169.21.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, Sep 1, 2011 at 2:30 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Some of the header file definitions of HDMI IP are needed by audio d=
river thus
>> moving the common defintion to more generic Include/video.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dss.h =A0| =A0 10 -----
>> =A0drivers/video/omap2/dss/hdmi.c | =A0 =A01 +
>> =A0drivers/video/omap2/dss/hdmi.h | =A0 53 ------------------------
>> =A0include/video/omaphdmi.h =A0 =A0 =A0 | =A0 86 +++++++++++++++++++=
+++++++++++++++++++++
>> =A04 files changed, 87 insertions(+), 63 deletions(-)
>> =A0create mode 100644 include/video/omaphdmi.h
>
> As the functions will be renamed to hdmi_ti_4xxx_*, perhaps the heade=
r
> file is a bit misnamed.
>
> Also, please first do the changes/renamings/etc, and only then move t=
he
> finished header file to include/video/ to prevent unnecessary changes=
 in
> include/video.
>
The Include/video hdmi header file is a generic file that can be used
across 4 ,5 and Netra. Actually even the hdmi_ti_5xxx_ definitions
would come in this header so what do you think it can be named as ? ,
If you have any better name for hdmi_ti_4xxx_ip as well please suggest
would be happy to take it , as it doesn't sound that intuitive to me
as well.

> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
