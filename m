From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Duplicate devkit8000 machine database entry
Date: Mon, 17 Aug 2009 19:00:42 +0100
Message-ID: <20090817180042.GV10764@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41720 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbZHQSAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 14:00:46 -0400
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1Md6Vg-0000ts-77
	for linux-omap@vger.kernel.org; Mon, 17 Aug 2009 19:00:44 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1Md6Ve-00046o-QZ
	for linux-omap@vger.kernel.org; Mon, 17 Aug 2009 19:00:42 +0100
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

For people's information:

Today, someone has added a new devkit8000 entry for OMAP3 with a useful
description of "nothing".

I'm expiring this entry right now - the machine database isn't supposed
to have multiple entries for the same platform.

Please ensure that no code is merged which references:
CONFIG_MACH_OMAP3_DEVKIT8000, MACH_TYPE_OMAP3_DEVKIT8000, or
machine_is_omap3_devkit8000().

Thanks.
