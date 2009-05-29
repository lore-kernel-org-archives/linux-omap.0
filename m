From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/10][RFC] Basic OMAP4 Clock framework support
Date: Fri, 29 May 2009 14:10:59 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03057E7930@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42685 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757294AbZE2IlF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2009 04:41:05 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8f14e007256
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:41:07 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4T8f07U013233
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 14:11:00 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

This patch series adds support for Basic OMAP4 clock framework and models all
clock nodes in PRM/CM1/CM2 modules and also models all the DPLL nodes.

This series has a dependency on [1] and can be applied on top of the 'for-next' branch. 

The series contains:
OMAP4: PM: Basic OMAP4 clock nodes
OMAP4: PM: Basic OMAP4 clock framework
OMAP4: PM: Add a dummy node to prevent crash at bootup
OMAP4: PM: ABE DPLL clock nodes
OMAP4: PM: PER DPLL clock nodes
OMAP4: PM: CORE DPLL clock nodes
OMAP4: PM: MPU DPLL clock nodes
OMAP4: PM: IVA DPLL clock nodes
OMAP4: PM: UNIPRO DPLL clock nodes
OMAP4: PM: Adds a few CM1/2 clock nodes

regards,
Rajendra

[1]: http://marc.info/?l=linux-omap&m=124358593421800&w=2

regards,
Rajendra