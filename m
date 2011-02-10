From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 0/5] omap2+: mux: Add support for static and dynamic pads.
Date: Thu, 10 Feb 2011 17:34:38 +0530
Message-ID: <c60d5c8bd1c40f9b67889f0682a4158a@mail.gmail.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:41091 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753609Ab1BJMEl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 07:04:41 -0500
Received: by mail-bw0-f48.google.com with SMTP id 8so2114623bwz.35
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 04:04:40 -0800 (PST)
In-Reply-To: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Tony,

>-----Original Message-----
>From: sricharan [mailto:r.sricharan@ti.com]
>Sent: Friday, January 28, 2011 10:38 AM
>To: r.sricharan@ti.com; linux-omap@vger.kernel.org
>Cc: santosh.shilimkar@ti.com; tony@atomide.com; paul@pwsan.com
>Subject: [PATCH 0/5] omap2+: mux: Add support for static and dynamic
pads.
>
>
>1) The support to add the pad data to the device hwmod entry and to use
>   it to dynamically configure the pads based on the state of the
>   hwmod is already present.
>
>2) But using that for pads that requires only initialisation and not
>   dynamic remux, brings in a overhead to iterate over all the
>   hwmod signals of the device for every device enable/idle transitions.
>
>3) By seperating the pads that requires remux as dynamic and the
>   ones that do not as static the above overhead is avoided.
>
>4) This way the static and dynamic pads are initialised,
>   and only dynamic pads are taken for remuxing.
>
>sricharan (5):
>  omap2+: mux: Seperate the pads of a hwmod as static and dynamic.
>  omap4: board-4430sdp: Initialise the serial pads
>  omap3: board-3430sdp: Initialise the serial pads.
>  omap4: board-omap4panda: Initialise the serial pads
>  omap2+: board-n8x0: Change the flags for the serial pads.
>
Any comments on this??

Thanks,
  Sricharan
