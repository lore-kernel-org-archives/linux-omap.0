From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v4 00/11] HDMI: Split hdmi.c in DSS to seperate OMAP dependent
Date: Thu, 8 Sep 2011 19:09:16 +0530
Message-ID: <CAP5A+B-iOL2xMLuLEyXbc_r8agoqpgXtJzszwdaySsZQbiBMkA@mail.gmail.com>
References: <1315310335-26054-1-git-send-email-mythripk@ti.com> <1315396542.2371.20.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:55945 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932789Ab1IHNjm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Sep 2011 09:39:42 -0400
Received: by mail-vw0-f48.google.com with SMTP id 7so966974vws.21
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 06:39:36 -0700 (PDT)
In-Reply-To: <1315396542.2371.20.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 7, 2011 at 5:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> Hi,
>
> On Tue, 2011-09-06 at 17:28 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> HDMI IP block is common between TI OMAP4 Procerssor and Netra proces=
sor although
>> the Display subsytem is different.Also the IP block in future OMAP m=
ay differ
>> from the one existing in OMAP4. Thus to reuse the code between these=
 two
>> processors , and maintain the multi omap build functionality in DSS.
>> HDMI IP dependant code is seperated out from hdmi.c and moved to
>> new library file hdmi_ti_4xxx_ip.c.From the DSS dependent HDMI code =
only the
>> function pointer to functionality/features offered by HDMI is called=
=2E
>>
>> This patch series does the split and also renames hdmi_omap4_panel.c=
 to
>> hdmi_panel.c as that file has nothing specific to OMAP4 and can be r=
eused for
>> other OMAP family of processors as well.
>>
>> This patch series is based on Tomi's LO-DSS2 master branch.
>>
>> changes since
>> v3:Handle the sparse error for set_pll_pwr function
>> Move audio functions out of hdmi.c to ip file.
>> rename hdmi_data to ip_data
>> V2: Rename certain files/function to have standard format and handle=
 scenario
>> when hdmi is disabled.
>> V1: Function pointer approach to call the HDMI IP functions from DSS=
 HDMI
>
> I think there's still lots of cleanups/restructuring needed for HDMI,
> but I'm willing to merge this patch set as it'll gives as a good
> baseline to continue the work, and trying to do too much in one go wo=
uld
> just be difficult.
>
> However, there are a couple of changes I wish you can do first:
>
> - Remove refsel. You still have an enum and a field for it, even if i=
t's
> not used.
>

Instead fixed the bug in the same patch to use refsel to be set in the =
PLL_CFG2.

> - Instead of creating include/video/ti_hdmi.h, create the file into
> drivers/video/omap2/dss/. Let's keep this totally inside DSS2 for the
> time being.
Sure done.
>
> - You still haven't changed copy_hdmi_to_dss_timings() to take a poin=
ter
> instead of a value. It's been commented at least three times already.=
 As
> similar things seem to happen quite often for you, if you have troubl=
e
> remembering all the required changes, please write the received comme=
nts
> down to, say, a piece of paper, and cross them over when you've actua=
lly
> made the change. It's a waste of reviewers time to review and comment
> the same problems again and again.
>
Point taken. Thanks for your review. Fixed this.

> - Go though the commit subjects and descriptions. I see the same typo=
es
> that I've also already commented about, and I see new ones also.
> Description on patch 10 is almost gibberish.
Added more details to most of patches in series. Posting the patch.

Mythri.
>
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
