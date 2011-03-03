From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 4/8] OMAP4 : DSS2 : HDMI: HDMI driver addition in the
 DSS drivers interface
Date: Thu, 3 Mar 2011 10:05:53 +0530
Message-ID: <AANLkTinM2QM2mcjKR3+BvXiyDv+9sHLq7HnsysRRauo+@mail.gmail.com>
References: <1298988988-28429-1-git-send-email-mythripk@ti.com>
	<1298988988-28429-5-git-send-email-mythripk@ti.com>
	<1299001044.2049.46.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:56649 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756041Ab1CCEfy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 23:35:54 -0500
Received: by mail-vw0-f47.google.com with SMTP id 4so811269vws.34
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 20:35:53 -0800 (PST)
In-Reply-To: <1299001044.2049.46.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,
I have checked for static functions :) .
Ok i will revisit the global variables to either move it to hdmi
struct or make it const.

Thanks and regards,
Mythri.

On Tue, Mar 1, 2011 at 11:07 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Tue, 2011-03-01 at 08:16 -0600, K, Mythri P wrote:
>> Adding the hdmi interface driver(hdmi.c) to the dss driver.
>> It configures the audio and video portion of HDMI in the
>> display header file to be accessed by the panels.
>
> Check once more if the private functions and variables are marked as
> static.
>
> The edid variables should be in the hdmi struct. The constant data
> arrays should be const.
>
> hdmi_power_on() leaves clocks on in case of error.
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
