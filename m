From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: [PATCH 0/2] dspbridge: proc: double free on error path
Date: Fri, 12 Feb 2010 18:26:52 +0200
Message-ID: <1265992014-7917-1-git-send-email-ext-phil.2.carmody@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63217 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab0BLQZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 11:25:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org


First a bit of a cleanup of what was clearly some legacy 'handle'
usage, and then a new quicker escape route for an error path to
avoid a double free.

It's tempting to get a bit more invasive, as there's a lot of
quite dodgy looking code (e.g. casting away const) in the areas
around my changes, but they'll have to wait for another time.


