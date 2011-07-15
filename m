From: "Zhang, Shijie" <shijie.zhang@intel.com>
Subject: How to get the handler of a device that has been open
Date: Fri, 15 Jul 2011 22:28:23 +0800
Message-ID: <6D7A567890E70E4BA49B8A9B365980FA12D9B1F5BD@shsmsx501.ccr.corp.intel.com>
References: <1310661218-3819-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28645 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab1GOObF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 10:31:05 -0400
In-Reply-To: <1310661218-3819-1-git-send-email-shubhrajyoti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "khilman@ti.com" <khilman@ti.com>

Hi all:

I have got a problem while I want to open a mutex device, which has been opened by another process. such as /dev/apls9802als, which is opened while the system boot up. But I have to do some test to its read function in its driver provided to the user space. Is there a way that I can close the handler that has been opened and reopen it by the test program I write? Any hacking way for this? Thanks.

Best Regards

Shijie
