From: Paul Walmsley <paul@pwsan.com>
Subject: 5912OSK NFS root broken on v3.5-rc3
Date: Thu, 21 Jun 2012 12:16:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206211212290.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47524 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932745Ab2FUSQ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 14:16:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@vger.kernel.org


The 5912OSK here no longer mounts NFS root:

http://www.pwsan.com/omap/bootlogs/20120620/omap_cleanup_a_3.6__07b3a13957aa250ff5b5409b8ed756b113544112/

This broke at some point between v3.4-rc2 and v3.5-rc3.


- Paul
