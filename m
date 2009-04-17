From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/02] OMAP3 clock: Remove virtual clock nodes
Date: Fri, 17 Apr 2009 11:27:42 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB251DD1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52628 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756162AbZDQF6X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 01:58:23 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jean Pihet <jpihet@mvista.com>

Resending this patch-set with some issues of tabs-to-spaces reported by Kevin Hilman
fixed and also some warning removals from Jean Pihet.

Patches apply on latest linux-omap pm branch  +
[PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver sent on 04/15/09
http://marc.info/?l=linux-omap&m=123980012121460&w=2

Hi,

This patch set removes the virtual clock node implementation for
VDD1/2 on omap3 which was causing issues with recursive locking of spinlocks.
All references to virtual clock nodes from resource framework and cpufreq
driver are removed. Resource framework now uses individual dpll clock
nodes to do frequency scaling.
Most of the functionality implemented as part of the virtual clock nodes
is now implemented internally in the resource framework.

Thanks to Tero Kristo <tero.kristo@nokia.com> who has implemented 
most of these changes.

regards,
Rajendra
