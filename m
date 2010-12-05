From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/2] Support for __read_mostly
Date: Sun, 5 Dec 2010 11:42:57 +0000
Message-ID: <20101205114257.GD9138@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34646 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969Ab0LELnI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 06:43:08 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This patch set adds support for __read_mostly - a separate section
which is used to hold data which is hardly ever written.

The idea behind this feature is to reduce the amount of cache line
bouncing between SMP cores by avoiding this data sharing cache lines
with data which is written more frequently.  As long as a cache line
is not dirtied, several cores can keep a copy of the data in their
caches.
