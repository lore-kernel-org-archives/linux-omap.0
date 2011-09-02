From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 04/10] OMAP4: DSS: HDMI: Move the common header file
Date: Fri, 2 Sep 2011 10:57:08 +0530
Message-ID: <CAP5A+B-K0sTqL7HJ4xNxyepyqmejV6WhVv_itZ8piMYyT9DjEg@mail.gmail.com>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
 <1314598500-24005-2-git-send-email-mythripk@ti.com> <1314598500-24005-3-git-send-email-mythripk@ti.com>
 <1314598500-24005-4-git-send-email-mythripk@ti.com> <1314598500-24005-5-git-send-email-mythripk@ti.com>
 <1314867624.2169.21.camel@lappyti> <CAP5A+B8j=6+a2m=Lpf0-G-arO9q2R_286=mHEv52qm4FiyWnZg@mail.gmail.com>
 <1314941043.1907.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:47296 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904Ab1IBF13 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 01:27:29 -0400
Received: by mail-iy0-f172.google.com with SMTP id c1so3359189iak.31
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 22:27:28 -0700 (PDT)
In-Reply-To: <1314941043.1907.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 2, 2011 at 10:54 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-09-02 at 10:45 +0530, K, Mythri P wrote:
>> Hi,
>>
>> On Thu, Sep 1, 2011 at 2:30 PM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
>> > On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
>> >> From: Mythri P K <mythripk@ti.com>
>> >>
>> >> Some of the header file definitions of HDMI IP are needed by audi=
o driver thus
>> >> moving the common defintion to more generic Include/video.
>> >>
>> >> Signed-off-by: Mythri P K <mythripk@ti.com>
>> >> ---
>> >> =A0drivers/video/omap2/dss/dss.h =A0| =A0 10 -----
>> >> =A0drivers/video/omap2/dss/hdmi.c | =A0 =A01 +
>> >> =A0drivers/video/omap2/dss/hdmi.h | =A0 53 ----------------------=
--
>> >> =A0include/video/omaphdmi.h =A0 =A0 =A0 | =A0 86 ++++++++++++++++=
++++++++++++++++++++++++
>> >> =A04 files changed, 87 insertions(+), 63 deletions(-)
>> >> =A0create mode 100644 include/video/omaphdmi.h
>> >
>> > As the functions will be renamed to hdmi_ti_4xxx_*, perhaps the he=
ader
>> > file is a bit misnamed.
>> >
>> > Also, please first do the changes/renamings/etc, and only then mov=
e the
>> > finished header file to include/video/ to prevent unnecessary chan=
ges in
>> > include/video.
>> >
>> The Include/video hdmi header file is a generic file that can be use=
d
>> across 4 ,5 and Netra. Actually even the hdmi_ti_5xxx_ definitions
>> would come in this header so what do you think it can be named as ? =
,
>> If you have any better name for hdmi_ti_4xxx_ip as well please sugge=
st
>> would be happy to take it , as it doesn't sound that intuitive to me
>> as well.
>
> Well, I think whatever the header name is, it should somehow match th=
e
> functions and the .c file. So if the functions and the .c file in thi=
s
> case are hdmi_ti_4xxx, then it'd be logical for the .h file to be nam=
ed
> similarly.
>
> So, if it will contain functions for other IPs also, perhaps just lea=
ve
> the 4xxx out of it and name it hdmi_ti.h. Then the functions could be
> named hdmi_ti_4xxx_yyy(), and accordingly the .c file can be
> hdmi_ti_4xxx.c.
>
> Or, perhaps ti_hdmi.h (and funcs & .c files accordingly) would be mor=
e
> "standard", as it's quite usual to name drivers etc. starting with th=
e
> company name.
>
Thanks i shall change it to ti_hdmi.h and rename functions accordingly.

Thanks and regards,
Mythri.
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
