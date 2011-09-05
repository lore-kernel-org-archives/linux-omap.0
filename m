From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v3 00/10]HDMI: Split hdmi.c in DSS to seperate OMAP dependent
Date: Mon, 5 Sep 2011 16:05:26 +0530
Message-ID: <CAP5A+B8+f8mnFPAOJ8E5HX-5AbSRPwicHSEaDke8s9tQ0Fj0KA@mail.gmail.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com> <1315208420.2130.31.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:55838 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752362Ab1IEKfs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Sep 2011 06:35:48 -0400
Received: by mail-vx0-f182.google.com with SMTP id 11so6645160vxh.27
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 03:35:46 -0700 (PDT)
In-Reply-To: <1315208420.2130.31.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Mon, Sep 5, 2011 at 1:10 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Fri, 2011-09-02 at 16:17 +0530, mythripk@ti.com wrote:
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
>> V2: Rename certain files/function to have standard format and handle=
 scenario
>> when hdmi is disabled.
>> V1: Function pointer approach to call the HDMI IP functions from DSS=
 HDMI
>
I guess i shall change the description , it is changes since , so v2
would be actually changes since v2 to v3.
> No change log for this version. It'd be nice to have it, so it's easi=
er
> to see what changes made into this version.
>
> I also see this when compiling with sparse:
>
> drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c:166:5: warning: symbol
> 'hdmi_set_pll_pwr' was not declared. Should it be static?
>
I missed running sparse i shall fix it and send out.

> =A0Tomi
>
>
>
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
