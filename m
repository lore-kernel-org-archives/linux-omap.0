From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 4/11] OMAP3: hwmod data: add dmtimer
Date: Wed, 05 Jan 2011 16:44:21 -0800
Message-ID: <87oc7uuahm.fsf@ti.com>
References: <1294228127-11549-1-git-send-email-tarun.kanti@ti.com>
	<1294228127-11549-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:33466 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754498Ab1AFAo2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 19:44:28 -0500
Received: by mail-yx0-f182.google.com with SMTP id 35so6760513yxh.13
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 16:44:27 -0800 (PST)
In-Reply-To: <1294228127-11549-5-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 5 Jan 2011 17:18:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Thara Gopinath <thara@ti.com>
>
> Add dmtimer data.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Acked-by: Cousson, Benoit <b-cousson@ti.com>

This patch only adds GPT1-11.  What about GPT12 which is not only
accessible on GP devices, on Beagle it is used as the system timer.

The result is this cannot boot on Beagle.

Kevin
