From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 5/5] OMAPDSS: HDMI: Add support to dump clocks through
Date: Tue, 20 Sep 2011 21:06:53 +0530
Message-ID: <CAP5A+B8inCnMnvrjDbtHUQ=t86HiOXvM6W+gPUVBAHcQLwH8=A@mail.gmail.com>
References: <1316522954-16594-1-git-send-email-mythripk@ti.com>
 <1316522954-16594-2-git-send-email-mythripk@ti.com> <1316522954-16594-3-git-send-email-mythripk@ti.com>
 <1316522954-16594-4-git-send-email-mythripk@ti.com> <1316522954-16594-5-git-send-email-mythripk@ti.com>
 <1316522954-16594-6-git-send-email-mythripk@ti.com> <1316525477.1949.20.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:59043 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750886Ab1ITPhO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 11:37:14 -0400
Received: by gxk4 with SMTP id 4so533412gxk.34
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 08:37:13 -0700 (PDT)
In-Reply-To: <1316525477.1949.20.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, Sep 20, 2011 at 7:01 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Tue, 2011-09-20 at 18:19 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Add support to dump the HDMI regm, regn, and other clock parameters.
>
> This patch doesn't work at all. It's checking for CONFIG_OMAP2_DSS_HD=
MI,
> whereas the actual define is CONFIG_OMAP4_DSS_HDMI. And even after
> fixing that, the output is:
>
> HDMI Clock Info
> regm =A0 =A0 =A0 =A0 =A0 =A0104regmf 104
> dcofreq 0regsd 1
> DSS_FCK (DSS_FCLK) =A0 =A0 =A0(off)
> hdmi fclk source =3D 3
>
These are the reg m , mf , dcofreq , by default the HDMI clock input is=
 sysclk ,
These values are based on the pixel clock.I suppose all the other
clock values are
printed via dss / dispc clock dump , is there any other dump that is mi=
ssing?
Thanks and regards,
Mythri.
> Did you test your patches at all?
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
