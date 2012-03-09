From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v4 3/3] OMAPDSS: HDMI: Sysfs support to configure quantization
Date: Fri, 9 Mar 2012 16:17:36 +0530
Message-ID: <CAP5A+B8J_y4GOMJ1pX1koYSDzGNA15i6ebY2i5ZZ5ZMZsvPE3A@mail.gmail.com>
References: <1328682261-22493-1-git-send-email-mythripk@ti.com>
 <1328682261-22493-2-git-send-email-mythripk@ti.com> <1328682261-22493-3-git-send-email-mythripk@ti.com>
 <1329222123.1845.82.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:35682 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751009Ab2CIKsJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 05:48:09 -0500
Received: by mail-iy0-f182.google.com with SMTP id k25so3225474iah.27
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 02:47:56 -0800 (PST)
In-Reply-To: <1329222123.1845.82.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Hi Tomi,

On Tue, Feb 14, 2012 at 5:52 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> Hi,
>

> The color range is something that desktops have to handle also, so
> there's probably ways to handle it in DRM. DisplayPort also has the s=
ame
> range setting, so it's not specific to HDMI.
>
> So I propose to add a kernel API for this in the omap_dss_driver, so
> that the users of omapdss may handle setting the range as they see be=
st.
>
I see , it is fine i shall make it generic dss API.
> Btw, the displayport spec speaks of VESA and CEA ranges. Does HDMI sp=
ec
> only speak about limited/full range?
>
Yes so is the case with HDMI it is full range for VGA and limited
range for rest.
> I also only now realized that we have full/limited range setting in
> video overlay's ATTRIBUTEs also. And it seems that we currently set i=
t
> always to 0, i.e. limited range. I wonder if this causes color
> degradation in case the HDMI/DP output also sets limited range, and t=
hus
> the color range gets scaled down twice...
>
yes there is a limited/full range bit in dispc for color conversion,
did a quick check using analyzer it doesn't impact the HDMI color
range, so can confirm there is no degradation.

Thanks and regards,
Mythri.
> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
