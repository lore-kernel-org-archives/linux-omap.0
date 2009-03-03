From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Queued patches
Date: Tue, 3 Mar 2009 16:52:24 +0000
Message-ID: <20090303165224.GE11096@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46634 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbZCCQwb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 11:52:31 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1LeXr0-0005ha-Qz
	for linux-omap@vger.kernel.org; Tue, 03 Mar 2009 16:52:27 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1LeXqz-0004EO-8D
	for linux-omap@vger.kernel.org; Tue, 03 Mar 2009 16:52:25 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The following patch set is what is in my omap-clks3 branch, which is
essentially my cleanups and conversion to clkdev, with Paul's work
cherry-picked on top.

As will be noticed from previous discussions, not all of Paul's work is
included since it requires further discussion and rework.
