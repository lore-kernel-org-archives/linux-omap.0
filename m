From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] Generic CPU save/restore PM support
Date: Fri, 11 Feb 2011 16:16:26 +0000
Message-ID: <20110211161626.GA31356@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34495 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811Ab1BKQQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 11:16:43 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following patch series implements infrastructure to save/restore
CPU state on suspend/resume PM events, and updates SA11x0, PXA and
Samsung platforms to use this.

Only only ARM920, ARM926, SA11x0, XScale, XScale3, V6 and V7 CPUs are
supported.

I've build-tested this for Assabet, PXA, and S3C2410, and boot tested
on Assabet.

Please send your acks/tested bys etc.
