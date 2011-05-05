From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: DSS pm_runtime problem
Date: Thu, 05 May 2011 18:59:49 +0300
Message-ID: <1304611189.30935.38.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34248 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755393Ab1EEP7x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 11:59:53 -0400
Received: by mail-ey0-f171.google.com with SMTP id d26so990635eyd.16
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 08:59:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: lo-ml <linux-omap@vger.kernel.org>

Hi Paul, Benoit,

I've started testing pm runtime with DSS, and I encountered a problem.

I'm using latest -rc5 as a base, and it looks like
omap_hwmod:_wait_target_ready() does not succeed for dss_core hwmod.
This causes _enable() to fail, but omap_device_enable_hwmods() does not
check the return values so it looks like everything went well, until the
driver crashes as the DSS HW module was off.

Ideas about _wait_target_ready()? And omap_device_enable_hwmods() would
need some fixing, I wasted quite a while debugging this =).

 Tomi


