From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 0/1] Fix OMAP_CHIP_INIT usage
Date: Thu, 23 Apr 2009 12:43:06 +0300
Message-ID: <1240479787-16921-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:23795 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753814AbZDWJnJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Apr 2009 05:43:09 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Found this chip init problem while debugging a problem with
usb host getting stuck at active mode when toggling the 
/sys/power/enable_off_mode. The OMAP_CHIP_INIT calls used
"is ES2.0" macros, while it should be now according to the new
macro definitions "greater or equal to ES2.0".

Boot tested on RX51 (smartreflex disabled, as there is that problem vp_init 
problem)

Should apply on latest pm branch.

- Kalle



