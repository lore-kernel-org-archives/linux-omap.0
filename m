From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Missing help texts
Date: Wed, 13 Jan 2010 12:54:00 +0000
Message-ID: <20100113125400.GA28292@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45662 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0AMMyK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 07:54:10 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1NV2jb-0001EZ-Cr
	for linux-omap@vger.kernel.org; Wed, 13 Jan 2010 12:54:03 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1NV2jZ-0007XV-Ct
	for linux-omap@vger.kernel.org; Wed, 13 Jan 2010 12:54:01 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Can you guys _please_ ensure that Kconfig entries have help texts before
they hit Linus' tree please?

Eg, without help texts, options such as "DSS_RFBI" make precisely zero
sense to people who don't know what DSS_RFBI is...
