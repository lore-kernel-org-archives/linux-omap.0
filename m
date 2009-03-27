From: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Subject: [PATCH 0/2] omap: twl4030_wdt: driver implementation
Date: Fri, 27 Mar 2009 16:42:16 +0200
Message-ID: <1238164938-11932-1-git-send-email-ext-atal.shargorodsky@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63728 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758536AbZC0On2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2009 10:43:28 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wim@iguana.be
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org


This is the simplest implementation of twl4030 watchdog driver.
Using this driver, the watchdog can be enabled/kicked/disabled,
but it does not take care of whether OFF-to-ACTIVE transition
will take place or not. Neither it supports the configuration
of PRETIMEOUT.


