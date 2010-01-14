From: Grazvydas Ignotas <notasas@gmail.com>
Subject: issue with panel drivers in DSS2
Date: Thu, 14 Jan 2010 22:59:31 +0200
Message-ID: <6ed0b2681001141259o3d81b949s69d44ab37f54c936@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:48657 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab0ANU7d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jan 2010 15:59:33 -0500
Received: by fxm25 with SMTP id 25so514163fxm.21
        for <linux-omap@vger.kernel.org>; Thu, 14 Jan 2010 12:59:32 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi,

there is an issue related to panel drivers:
even if panel driver provides get_rotate/set_rotate and/or
get_mirror/set_mirror functions, those cannot be accessed over sysfs,
even though corresponding entries are created in omapdss/displayX.
This is because panel driver fills omap_dss_driver structure, but
sysfs entries are created for omap_dss_device when it probes. So
perhaps those pointers need to be copied from omap_dss_driver to
omap_dss_device somewhere in dss_driver_probe().
