From: Michael Jones <michael.jones@matrix-vision.de>
Subject: omap3camera and linux-omap
Date: Fri, 06 Aug 2010 15:48:10 +0200
Message-ID: <4C5C129A.3020808@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.matrix-vision.com ([85.214.244.251]:38592 "EHLO
	mail2.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861Ab0HFN5u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 09:57:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sakari.ailus@maxwell.research.nokia.com

I am currently using Sakari's omap3camera repository (branch 'devel'). 'git merge-base linux-omap omap3camera' tells me that the last commit omap3camera has in common with linux-omap is 40a0c47, from July 7 2010.  But there are >1000 commits which are only in omap3camera, dating back to 2008.

Is this destined to stay this way?  Or will the omap3camera tree be merged into linux-omap at some point?

When proposing a patch for the omap3camera tree, should it be sent to this list?

Thanks,
Michael

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-Joachim Reich
