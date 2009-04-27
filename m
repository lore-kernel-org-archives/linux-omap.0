From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: [PATCH 0/2] OMAP3: PM: More pedantic parameter and error checking in smartreflex
Date: Mon, 27 Apr 2009 19:26:23 +0300
Message-ID: <1240849585-14828-1-git-send-email-ext-phil.2.carmody@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32530 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbZD0QZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 12:25:55 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3RGOsnA019637
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2009 11:25:55 -0500
Received: from localhost.localdomain (esdhcp04266.research.nokia.com [172.21.42.66])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n3RGPhGW021911
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2009 19:25:43 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


A couple of simple patches to improve error handling in smartreflex.
The first has a practical benefit of avoiding a string-based search
in situtations where the result wouldn't be needed. The second is
simple paranoia.

