From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH] omap2+: mux: Remove the use of IDLE flag.
Date: Wed, 9 Mar 2011 13:19:27 +0530
Message-ID: <3454d5fcdc4f7fb8e8a5bcaffca95112@mail.gmail.com>
References: <1299472552-22017-1-git-send-email-r.sricharan@ti.com> <20110308164033.GC26463@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:45852 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751997Ab1CIHtc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 02:49:32 -0500
Received: by mail-wy0-f180.google.com with SMTP id 26so205623wyj.25
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 23:49:31 -0800 (PST)
In-Reply-To: <20110308164033.GC26463@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, paul@pswan.com, linux-arm-kernel@lists.infradead.org

Tony,
>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Tony Lindgren
>Sent: Tuesday, March 08, 2011 10:11 PM
>To: sricharan
>Cc: linux-omap@vger.kernel.org; b-cousson@ti.com;
santosh.shilimkar@ti.com;
>paul@pswan.com
>Subject: Re: [PATCH] omap2+: mux: Remove the use of IDLE flag.
>
>* sricharan <r.sricharan@ti.com> [110306 20:33]:
>> Currently OMAP_DEVICE_PAD_IDLE flag is used to mux pins
>> dynamically. This can be simplified by using the enabled
>> state variable of each pad. This also fixes the issue of
>> the static pads not getting muxed after idling and
>> disable/enable state transitions.
>
>Looks good, can you please repost one more time with linux-arm-kernel
>mailing list also Cc'd?
>
Ok sure. I have  re posted  this to the linux-arm-kernel list.
>Thanks,
>
>Tony
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
