From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: High iowait time with NFS on OMAP3EVM
Date: Thu, 14 May 2009 21:15:42 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5095B71@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37494 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbZENPpt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 11:45:49 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4EFjilV028571
	for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 10:45:50 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4EFjhLc027599
	for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 21:15:43 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
When I copy a large file to/from NFS mounted filesystem, the system becomes
unresponsive and top command shows very high iowait(80%+) time. Though the IO operation goes through, typical throughput is < 8Mbps/sec.

On the same system, testing for Ethernet driver throughput using iperf yields close to 50Mb/sec throughput. (I am using the tip of linux-omap and running on OMAP3EVM using smc911x driver)

Any pointers on what could result in degradation of throughput when using NFS and the resulting high iowait time?

Regards
Sriram

