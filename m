From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2 0/2] bus: omap_l3_noc: Add resume hook to restore mask
 registers
Date: Wed, 12 Nov 2014 21:57:17 +0530
Message-ID: <54638A65.1090100@ti.com>
References: <1415643588-14508-1-git-send-email-j-keerthy@ti.com> <20141112151704.GD26481@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49879 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbaKLQaK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 11:30:10 -0500
In-Reply-To: <20141112151704.GD26481@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, nm@ti.com, afzal@ti.com

On Wednesday 12 November 2014 08:47 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [141110 10:25]:
>> l3_noc module loses context during both DS0 and RTC+DDR in self refresh modes.
>> This causes the previously masked l3 interrupts to trigger and the software
>> book keeping assumes the interrupts are masked and does nothing to mask.
>> This software/hardware out of sync leads to back to back l3 interrupts
>> and eventually causes a hang. Hence adding resume hook to restore the
>> mask registers based on the book keeping variables
> Applying both into omap-for-v3.19/drivers-v2 branch thanks.

Thanks Tony.

>
> Tony

