From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Display not working if omapdrm is builtin with 3.15rc
Date: Fri, 2 May 2014 12:47:04 +0200
Message-ID: <3A6485D2-7FEA-4C7E-9541-B814DFEE17A2@dominion.thruhere.net>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:58942 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbaEBKrJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2014 06:47:09 -0400
Received: by mail-wi0-f176.google.com with SMTP id f8so2125601wiw.9
        for <linux-omap@vger.kernel.org>; Fri, 02 May 2014 03:47:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

I've been trying to get DVI on my beagleboard XM to output a picture with mainline and with 3.15rc it still doesn't work. If I statically build in everything the drm encoders and connectors all go into deferred probe mode and fail, falling back to 1024x768. I with omapdrm and encoders/outputs/etc as modules deferred probe is avoided, far fewer error messages and a 1280x1024 resolution is being used. But still the monitor still says 'no signal' detected.

So what's the magic to get an actual signal on the hdmi connector?

regards,

Koen