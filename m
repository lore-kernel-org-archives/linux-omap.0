From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 5/8] OMAP4 : DSS2 : HDMI: HDMI panel driver addition in
 the DSS
Date: Thu, 3 Mar 2011 09:58:41 +0530
Message-ID: <AANLkTinfjZBum5s6Dujta5LiVsXtzn99ePH-acrLouVx@mail.gmail.com>
References: <1298988988-28429-1-git-send-email-mythripk@ti.com>
	<1298988988-28429-6-git-send-email-mythripk@ti.com>
	<1298999470.2049.37.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36730 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758123Ab1CCE2m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 23:28:42 -0500
Received: by mail-vx0-f170.google.com with SMTP id 39so1119504vxb.1
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 20:28:41 -0800 (PST)
In-Reply-To: <1298999470.2049.37.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Mar 1, 2011 at 10:41 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Tue, 2011-03-01 at 08:16 -0600, K, Mythri P wrote:
>> The panel driver(hdmi_omap4_panel.c) in dss file acts as a controlle=
r
>> to manage the enable and disable requests and synchronize audio and =
video.
>> Also the header file to export the hdmi registers is added in the
>> plat-omap , so that it can be accessed by audio driver.
>
> Could you review the description. The panel driver is not in "dss fil=
e"
> and there's no header in this patch.
>
> The locking is broken in this patch. You cannot return from the funct=
ion
> while holding the lock.
I shall fix the lock and describe appropriately.
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
