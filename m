From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 0/2] OMAP3: Cpuidle fixes
Date: Mon, 26 Oct 2009 15:10:38 +0200
Message-ID: <1256562640-15242-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45560 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721AbZJZN0f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 09:26:35 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9QDQOB9031245
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 08:26:39 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9QDPWI1028570
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 15:25:32 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Following patches apply on top of PM branch. They implement a couple of
small fixes for cpuidle. Timer resolution patch probably does not change
anything until kernel cpuidle is fixed to support longer timers (there are
some pending patches for this.)

-Tero


