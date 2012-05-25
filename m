From: Thomas Klute <thomas2.klute@uni-dortmund.de>
Subject: Ftrace Timer on OMAP3
Date: Fri, 25 May 2012 17:19:07 +0200
Message-ID: <4FBFA2EB.708@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.HRZ.Uni-Dortmund.DE ([129.217.128.51]:38777 "EHLO
	unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab2EYPTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 11:19:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Carsten Vogel <carsten.vogel@rub.de>

Hi everyone,

we're having some trouble getting useful results from Ftrace on OMAP3
(Gumstix Overo). As you can see in the example output below, function
duration can't be displayed with a precision higher than about 30.5 us,
which matches the frequency of the 32 kHz platform timer. For OMAP1,
using OMAP_MPU_TIMER instead of CONFIG_OMAP_32K_TIMER should provide
better results [1], but I couldn't find anything similar for OMAP3. Just
setting CONFIG_OMAP_32K_TIMER=N didn't change the results. Did I miss
anything, or isn't there any more precise timer?

Best regards,
Thomas Klute

[1]
http://elinux.org/images/0/0c/Bird-LS-2009-Measuring-function-duration-with-ftrace.pdf

Example Ftrace output:

  876.252136 |   0)               |  sys_sendmsg() {
  876.252166 |   0)               |    rom_rtadd() {
  876.252197 |   0)   0.000 us    |      release_queue_for_dst();
  876.252197 |   0)   0.000 us    |      add_route();
  876.252197 |   0) + 30.517 us   |    }
  876.252258 |   0) + 91.553 us   |  }
--
  876.311859 |   0)               |  sys_sendmsg() {
  876.311889 |   0)               |    rom_rtadd() {
  876.311889 |   0) + 30.518 us   |      release_queue_for_dst();
  876.311920 |   0)   0.000 us    |      add_route();
  876.311920 |   0) + 30.518 us   |    }
  876.311950 |   0) + 91.552 us   |  }
--
  876.371704 |   0)               |  sys_sendmsg() {
  876.371765 |   0)               |    rom_rtadd() {
  876.371765 |   0)   0.000 us    |      release_queue_for_dst();
  876.371765 |   0)   0.000 us    |      add_route();
  876.371795 |   0) + 30.517 us   |    }
  876.371826 |   0) ! 122.071 us  |  }
