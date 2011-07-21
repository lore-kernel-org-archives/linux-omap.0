From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: omap_device prints
Date: Thu, 21 Jul 2011 10:51:09 +0100
Message-ID: <20110721095109.GC28942@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40221 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab1GUJvO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jul 2011 05:51:14 -0400
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1QjpuR-0003aT-9W
	for linux-omap@vger.kernel.org; Thu, 21 Jul 2011 10:51:11 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1QjpuQ-0000kh-12
	for linux-omap@vger.kernel.org; Thu, 21 Jul 2011 10:51:10 +0100
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I spotted this while booting the OMAP4430 SDP:

omap_device: omap4-keypad.-1: new worst case activate latency 0: 61035

and found that it came from here:

        pr_debug("omap_device: %s: activating\n", od->pdev.name);

                pr_debug("omap_device: %s: pm_lat %d: activate: elapsed time "
                         "%llu nsec\n", od->pdev.name, od->pm_lat_level,
                         act_lat);

                                pr_warning("omap_device: %s.%d: new worst case "
                                           "activate latency %d: %llu\n",
                                           od->pdev.name, od->pdev.id,
                                           od->pm_lat_level, act_lat);
                                pr_warning("omap_device: %s.%d: activate "
                                           "latency %d higher than exptected. "
                                           "(%llu > %d)\n",
                                           od->pdev.name, od->pdev.id,
                                           od->pm_lat_level, act_lat,
                                           odpl->activate_lat);

Is there something wrong with dev_name(&od->pdev.dev) so that we have
consistent naming of devices, rather than poking about inside the
platform_device accessing the name initializers directly ?

