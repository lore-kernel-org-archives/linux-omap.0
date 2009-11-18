From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Query: Enabling DEBUG_LL on Zoom2/3 boards
Date: Wed, 18 Nov 2009 17:11:03 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CAAA6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47937 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbZKRLlE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 06:41:04 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAIBf7kw026471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 05:41:09 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAIBf6R8022711
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 17:11:06 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

Vikram,

With the recent changes to DEBUG_LL on Zoom2/3 boards,
it looks like I can no longer get any debug UART activity
if DEBUG_LL is enabled on these boards (tested on Zoom3).

Is it fair to expect at least the normal UART activity to
work even when CONFIG_DEBUG_LL is enabled and
CONFIG_OMAP_LL_DEBUG_NONE is set?

- Anand
