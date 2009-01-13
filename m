From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH v2] OMAP: Fix McBSP spin_lock deadlock.
Date: Tue, 13 Jan 2009 11:08:44 +0200
Message-ID: <1231837724.13843.128.camel@eenurkka-desktop>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64756 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbZAMJLO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 04:11:14 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0D9AgoD020588
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 11:11:11 +0200
Received: from [172.23.118.146] (ouped118146.nmp.nokia.com [172.23.118.146])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n0D9ArYh030373
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 11:10:53 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

> Can you please repost your first version of the patch?

Please. This V1 patch is good if one wishes to provide the fclk
for McBSP from the MCBSP_CLKS. Then the fclk from the per can be turned
off. With the V2 patch it's not that straightforward at all.

- Eero

