From: Afzal Mohammed <lazfamam@gmail.com>
Subject: [PATCH] OMAP:DSS2:OMAPFB: Fix probe error path
Date: Thu,  1 Jul 2010 19:10:00 +0530
Message-ID: <1277991601-16528-1-git-send-email-lazfamam@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53652 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab0GANrB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 09:47:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: ville.syrjala@nokia.com, tj@kernel.org, lazfamam@gmail.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Tomi,

Is this change ok instead of having sysfs entry removal in omapfb_free_resources() ?
Hope this change makes probe look more of a remove mirror.

Regards
Afzal
