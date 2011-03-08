From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v3 0/9] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Tue, 8 Mar 2011 13:38:39 +0530
Message-ID: <AANLkTim0S_jD8LfPrd+8g_OCturjTAP2qs=757vEJBYf@mail.gmail.com>
References: <1299224907-11354-1-git-send-email-mythripk@ti.com>
	<1299487205.2281.81.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:55002 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754875Ab1CHIIl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 03:08:41 -0500
Received: by mail-vx0-f176.google.com with SMTP id 40so5087991vxi.7
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 00:08:40 -0800 (PST)
In-Reply-To: <1299487205.2281.81.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Mon, Mar 7, 2011 at 2:10 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Fri, 2011-03-04 at 01:48 -0600, K, Mythri P wrote:
>> Adding HDMI support on OMAP4.
>>
>> HDMI is a driver that is similar to the VENC or the DSI driver to su=
pport
>> HDMI/DVI sink device.
>
> <snip>
>
>> 1. v10 of omap2,3 hwmod DSS adaptation:
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42914.html
>> 2. v3 of OMAP2PLUS: DSS: Generalize clock names
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43338.html
>> 3. v3 of OMAP4: hwmod DSS support:
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43177.html
>> 4. OMAP: DSS2: Adding dss_features for independent core clk divider
>> https://patchwork.kernel.org/patch/529561/
>> 5. OMAP2PLUS-DSS2-Make-members-of-dss_clk_source-generic
>
> I believe all these are now in DSS2 tree's master branch, so can you
> rebase the next version on top of the master branch?
I will rebase my patch. And list only dependency ie not present , if ne=
eded.
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
