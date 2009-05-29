From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/06] [RFC] Basic OMAP4 PRCM register def series
Date: Fri, 29 May 2009 14:01:29 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03057E792A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42330 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbZE2IcC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2009 04:32:02 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8VVUg001735
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:32:03 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4T8VUR2011298
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 14:01:31 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

This series contains patches which define OMAP4430 PRM/CM1/CM2 module register offsets
and masks.

These are generated on top of the Basic OMAP4 boot support patches posted to the list and which are
lined up for merge in the 'for-next' branch.
These patches hence can be applied directly on the for-next branch.

The series contains:
OMAP4: PM: Fix the PRM and CM base addresses
OMAP4: PM: PRM/CM module offsets for OMAP4
OMAP4: PM: Adds PRM register defs for OMAP4
OMAP4: PM: Adds PRM register shift and mask bits
OMAP4: PM: Adds CM1/2 register defs for OMAP4
OMAP4: PM: Adds CM1/2 register field masks

regards,
Rajendra