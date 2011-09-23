From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCHv3 5/5] OMAPDSS: HDMI: Add support to dump clocks through
Date: Fri, 23 Sep 2011 16:50:43 +0530
Message-ID: <CAP5A+B_gtKAWHs=4xt9LHCAokZJqQyH05w7pYx1TM8m4nKe2PA@mail.gmail.com>
References: <1316770341-19140-1-git-send-email-mythripk@ti.com> <1316774745.6909.2.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33689 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753284Ab1IWLVH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 07:21:07 -0400
Received: by vws5 with SMTP id 5so4149153vws.3
        for <linux-omap@vger.kernel.org>; Fri, 23 Sep 2011 04:21:03 -0700 (PDT)
In-Reply-To: <1316774745.6909.2.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 23, 2011 at 4:15 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-09-23 at 15:02 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Add support to dump the HDMI PLL dividers such as regm, regn etc
>> and other clock dumps such as pixel clock rate, TMDS clock rate.
>>
>> changes since V2:
>> Add pixel clock and TMDS clock dump and remove dcofreq and DISPC clo=
ck source
>> print.
>
> Let's drop this fifth patch for now, I think the hdmi pll code needs =
a
> bit cleaning up before we can have a good dump clocks support.
>
> I'll take the patches 1-4 and apply to dss2 master.
>
> Btw, this patch, and the 4th patch, still have broken subject. I gues=
s
> this is fourth time I mention it. I'll fix it myself in the patches I
> apply.
>
I shall mail the fourth patch , As only change suggested was subject ch=
ange,
I wanted to send it if this patch was ok.
Anyways mailing it to you.

Thanks and regards,
Mythri.
after
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
