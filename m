From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: PM: off mode
Date: Tue, 14 Jul 2009 15:01:21 +0300
Message-ID: <4A5C7391.5050604@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44024 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZGNMB6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 08:01:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

  Off mode does not seem to work on RX51 on latest PM branch. I get a reboot if 
I set enable_off_mode and sleep_while_idle and I wait for timeout.

  Does it work on other platforms?

regards,
-roger
