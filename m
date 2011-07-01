From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Build issue.
Date: Fri, 01 Jul 2011 15:37:10 +0100
Message-ID: <4E0DDB96.3090707@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:37431 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab1GAO3E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 10:29:04 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:43396)
	by ppsw-41.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1QceiN-0001T1-Qw (Exim 4.72) for linux-omap@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Fri, 01 Jul 2011 15:29:03 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

No time to look into this now, but linux next today is giving:

  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      drivers/media/video/omap/omap_vout.o
drivers/media/video/omap/omap_vout.c: In function 'omap_vout_probe':
drivers/media/video/omap/omap_vout.c:2549:15: error: 'struct omap_dss_driver' has no member named 'set_update_mode'
drivers/media/video/omap/omap_vout.c:2550:12: error: 'struct omap_dss_driver' has no member named 'set_update_mode'
drivers/media/video/omap/omap_vout.c:2551:8: error: 'OMAP_DSS_UPDATE_MANUAL' undeclared (first use in this function)
drivers/media/video/omap/omap_vout.c:2551:8: note: each undeclared identifier is reported only once for each function it appears in
drivers/media/video/omap/omap_vout.c:2553:15: error: 'struct omap_dss_driver' has no member named 'set_update_mode'
drivers/media/video/omap/omap_vout.c:2554:12: error: 'struct omap_dss_driver' has no member named 'set_update_mode'
drivers/media/video/omap/omap_vout.c:2555:8: error: 'OMAP_DSS_UPDATE_AUTO' undeclared (first use in this function)
make[4]: *** [drivers/media/video/omap/omap_vout.o] Error 1
make[3]: *** [drivers/media/video/omap] Error 2
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

Have I missed a relevant patch?
