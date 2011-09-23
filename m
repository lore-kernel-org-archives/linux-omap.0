From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 5/5] OMAPDSS: HDMI: Add support to dump clocks through
Date: Fri, 23 Sep 2011 12:10:28 +0530
Message-ID: <CAP5A+B_igRKKLadqqrRo7NVGP=uKbTmpnmajfDSD8neLJyYYxQ@mail.gmail.com>
References: <1316678866-17749-1-git-send-email-mythripk@ti.com>
 <1316678866-17749-2-git-send-email-mythripk@ti.com> <1316678866-17749-3-git-send-email-mythripk@ti.com>
 <1316678866-17749-4-git-send-email-mythripk@ti.com> <1316678866-17749-5-git-send-email-mythripk@ti.com>
 <1316678866-17749-6-git-send-email-mythripk@ti.com> <1316692870.2442.24.camel@deskari>
 <CAP5A+B-Ahwfk4tu3OtvRpfejFbv_jVpiVmoNJW0cGTfiwkG7kA@mail.gmail.com> <1316757668.1901.12.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:50781 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105Ab1IWGkv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 02:40:51 -0400
Received: by vcbfo11 with SMTP id fo11so1078381vcb.3
        for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 23:40:49 -0700 (PDT)
In-Reply-To: <1316757668.1901.12.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 23, 2011 at 11:31 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> On Fri, 2011-09-23 at 11:22 +0530, K, Mythri P wrote:
>
>> > - What is dcofreq? Looking at the code, it tells if the pixel cloc=
k is >
>> > 1000MHz. Why is such a field needed, can't the HDMI driver manage =
that
>> > itself? And if it's needed, why is it called dcofreq, the name doe=
sn't
>> > make much sense to me.
>> It is DCO frequency, It suggest the frequency selector range ,
>
> The field is not DCO frequency, it's a boolean, 0 or 1. That's why th=
e
> name doesn't really make sense to me.
>
>> HDMI_PLL_CONFIGURATION2 (3:1) has to be set accordingly by the drive=
r
>> depending on whether the CLKOUTLDO is greater than or less than
>> 1000Mhz, but anyways the decision is taken by the driver.
>
> But can't it be done in the ti_hdmi driver, at the same time when
> programming the registers? Why do we need to set the boolean beforeha=
nd.
>
It can be done, It is not a boolean , boolean logic is used to
determine the value 0x2 / 0x4.
Page # 101. (DCO frequency).

>> Also the name is as suggested by TRM .
>
> I couldn't find boolean dcofreq in the TRM.
>
>> > - We are doing HDMI PLL calculations in the omapdss drivers hdmi.c=
 file.
>> > The PLL calculations are PLL specific, and thus should be in the
>> > specific HDMI implementation file, right?
>> >
>> >> + =A0 =A0 seq_printf(s, "DISPC clock source %s (%s)\t(%s)\n",
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dss_get_generic_clk_sou=
rce_name(dispc_clk_src),
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dss_feat_get_clk_source=
_name(dispc_clk_src),
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dispc_clk_src =3D=3D OM=
AP_DSS_CLK_SRC_FCK ?
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "off" : "on");
>> >
>> > Why do you print DISPC clock source? How is that part of HDMI cloc=
k
>> > configuration?
>> Reason is to check whether the DISPC clock source is PRCM / DSI PLL,
>> Because DSI PLL might not be sufficient.
>
> But it's already printed by the DISPC section, and it's not part of
> HDMI, so I don't quite see the need.
>
> What do you mean DSI PLL might not be sufficient? We can get higher
> DISPC clocks with DSI PLL than with PRCM.
Well , from the older calculation / values passed to DSI ,
it was seen that DSI PLL was in the order of 156Mhz, and PRCM with 186M=
hz.
This had resulted in underflow issues with HDMI.
>
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
