From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v4 6/9] OMAP4 : DSS2 : HDMI: HDMI panel driver addition in
 the DSS
Date: Thu, 10 Mar 2011 10:57:03 +0530
Message-ID: <AANLkTimx3i6E3U7hey1ARZaa0X-jhESXNkiaZiYZUaHB@mail.gmail.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	<1299671118-20839-2-git-send-email-mythripk@ti.com>
	<1299671118-20839-3-git-send-email-mythripk@ti.com>
	<1299671118-20839-4-git-send-email-mythripk@ti.com>
	<1299671118-20839-5-git-send-email-mythripk@ti.com>
	<1299671118-20839-6-git-send-email-mythripk@ti.com>
	<1299671118-20839-7-git-send-email-mythripk@ti.com>
	<1299680636.2151.96.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:45102 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788Ab1CJF1F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 00:27:05 -0500
Received: by mail-vx0-f172.google.com with SMTP id 33so1467054vxg.31
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 21:27:04 -0800 (PST)
In-Reply-To: <1299680636.2151.96.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Wed, Mar 9, 2011 at 7:53 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Wed, 2011-03-09 at 05:45 -0600, K, Mythri P wrote:
>> The panel driver(hdmi_omap4_panel.c) in omap2/dss acts as a controll=
er
>> to manage the enable and disable requests and synchronize audio and =
video.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08=
 +
>> =A0drivers/video/omap2/dss/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/video/omap2/dss/hdmi_omap4_panel.c | =A0209 +++++++++++++=
+++++++++++++++
>> =A03 files changed, 218 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/video/omap2/dss/hdmi_omap4_panel.c
>>
>> diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/d=
ss/Kconfig
>> index 7749ddb..f66043f 100644
>> --- a/drivers/video/omap2/dss/Kconfig
>> +++ b/drivers/video/omap2/dss/Kconfig
>> @@ -125,4 +125,12 @@ config OMAP2_DSS_MIN_FCK_PER_PCK
>> =A0 =A0 =A0 =A0 Max FCK is 173MHz, so this doesn't work if your PCK
>> =A0 =A0 =A0 =A0 is very high.
>>
>> +config OMAP4_PANEL_HDMI
>> + =A0 =A0 bool "HDMI panel support"
>> + =A0 =A0 depends on OMAP2_DSS_HDMI
>> + =A0 =A0 =A0 =A0default n
>> + =A0 =A0 help
>> + =A0 =A0 =A0 HDMI panel. This adds the High Definition Multimedia p=
anel.
>> + =A0 =A0 =A0 See http://www.hdmi.org/ for HDMI specification.
>> +
>> =A0endif
>> diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/=
dss/Makefile
>> index 5998b69..7ee4093 100644
>> --- a/drivers/video/omap2/dss/Makefile
>> +++ b/drivers/video/omap2/dss/Makefile
>> @@ -6,3 +6,4 @@ omapdss-$(CONFIG_OMAP2_DSS_VENC) +=3D venc.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_SDI) +=3D sdi.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_DSI) +=3D dsi.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_HDMI) +=3D hdmi.o
>> +omapdss-$(CONFIG_OMAP4_PANEL_HDMI) +=3D hdmi_omap4_panel.o
>
> You don't need CONFIG_OMAP4_PANEL_HDMI. In fact, you cannot have it:
> hdmi.c calls the panel driver, so they must be compiled in or out
> together.
>
> Also, as they depend on each other, adding them in patches like this
> breaks compilation. Do it so that first add hdmi.c in a patch. Then
> hdmi_omap4_panel.c. After those, add Kconfig and Makefile changes. Th=
is
> way the kernel stays compilable, and you can still have the additions
> divided into separate patches.
Sure i will do that.
>
> =A0Tomi
>
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
