From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap: 4430sdp board support for the the GPIO keys
Date: Tue, 31 Aug 2010 09:02:03 -0700
Message-ID: <87vd6qsrd0.fsf@deeprootsystems.com>
References: <1283269578-3962-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33131 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab0HaQCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 12:02:07 -0400
Received: by pwi3 with SMTP id 3so425024pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Aug 2010 09:02:06 -0700 (PDT)
In-Reply-To: <1283269578-3962-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Tue, 31 Aug 2010 21:16:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> omap 4430sdp board support for the GPIO keys.
> The proximity sensor is connected to GPIO and is registered as a
> GPIO key.
> - Making the default state of the sensor off at bootup
> - The init is called before platform_add_devices
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

I still think the subject is wrong:  You're adding support for the
proximity sensor *using* GPIO keys, not adding support for GPIO keys:

    OMAP: 4430SDP: add proximity sensor via GPIO keys

or something like that.

Kevin

