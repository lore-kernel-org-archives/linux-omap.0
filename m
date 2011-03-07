From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 5/6] omap4: Initialise the l3 device with the hwmod data.
Date: Mon, 7 Mar 2011 16:55:11 +0530
Message-ID: <a5b513f977b3d64a5911eab80fa1306d@mail.gmail.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
 <1298295990-1070-6-git-send-email-santosh.shilimkar@ti.com>
 <4D62AAAA.40104@ti.com> <295be59bd43a2e9f0961c10263ce19c0@mail.gmail.com>
 <4D74B1D6.8020708@ti.com> <435c01d5b0d5a1448f64bc1129fe348f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39850 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221Ab1CGLZN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 06:25:13 -0500
Received: by mail-qw0-f49.google.com with SMTP id 9so4650923qwj.22
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 03:25:12 -0800 (PST)
In-Reply-To: <435c01d5b0d5a1448f64bc1129fe348f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Sricharan R <r.sricharan@ti.com>

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Monday, March 07, 2011 4:49 PM
> To: Benoit Cousson
> Cc: linux-omap@vger.kernel.org; Felipe Balbi; Sricharan R
> Subject: RE: [PATCH 5/6] omap4: Initialise the l3 device with the
> hwmod data.
>

[....]
> Ok. So let's go with the IP names then.
> New file names will be as above.
>
> omap_l3_3xxx.c
> omap_l3_4xxx.c

Sorry I mean ...

omap_l3_noc.c
omap_l3_smx.c


Regards,
Santosh
