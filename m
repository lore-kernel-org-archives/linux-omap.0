From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] bus: omap_l3_noc: Add resume hook to restore mask
 registers
Date: Wed, 12 Nov 2014 07:17:05 -0800
Message-ID: <20141112151704.GD26481@atomide.com>
References: <1415643588-14508-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38819 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbaKLPRo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 10:17:44 -0500
Content-Disposition: inline
In-Reply-To: <1415643588-14508-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, afzal@ti.com

* Keerthy <j-keerthy@ti.com> [141110 10:25]:
> l3_noc module loses context during both DS0 and RTC+DDR in self refresh modes.
> This causes the previously masked l3 interrupts to trigger and the software
> book keeping assumes the interrupts are masked and does nothing to mask.
> This software/hardware out of sync leads to back to back l3 interrupts
> and eventually causes a hang. Hence adding resume hook to restore the
> mask registers based on the book keeping variables

Applying both into omap-for-v3.19/drivers-v2 branch thanks.

Tony
