From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 0/2] Fix/Clean regulator consumer mapping for 3430sdp
Date: Wed, 16 Feb 2011 17:49:03 +0530
Message-ID: <147642dc9bed7d0af86fc618cca09edd@mail.gmail.com>
References: <1296737122-20765-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:47954 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758987Ab1BPMTH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 07:19:07 -0500
Received: by mail-fx0-f44.google.com with SMTP id 9so1481982fxm.3
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 04:19:05 -0800 (PST)
In-Reply-To: <1296737122-20765-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

Tony,

> -----Original Message-----
> From: Rajendra Nayak [mailto:rnayak@ti.com]
> Sent: Thursday, February 03, 2011 6:15 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; linux-arm-kernel@lists.infradead.org;
balbi@ti.com; Rajendra Nayak
> Subject: [PATCH v2 0/2] Fix/Clean regulator consumer mapping for 3430sdp
>
> This is a short series to fix some, and clean the
> existing regulator consumer supply mappings for
> the OMAP3430sdp board.
>
> The series is boot tested on the 3430sdp board
> and applies on 2.6.38-rc3.

Any plans to pull these 3430sdp board file cleanup/fixes?

Regards,
Rajendra

>
> Changes in v2:
> Define regulator_consumer_supply as array's
> and use ARRAY_SIZE macro to define
> num_consumer_supplies
>
> Rajendra Nayak (2):
>   omap3sdp: Fix regulator mapping for ads7846 TS controller
>   omap3sdp: clean regulator supply mapping in board file
>
>  arch/arm/mach-omap2/board-3430sdp.c |   78
+++++++++++++++++------------------
>  1 files changed, 38 insertions(+), 40 deletions(-)
