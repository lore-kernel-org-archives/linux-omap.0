From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/8] OMAP3 PM: Defining .pwrsts_logic_ret field for core
 power domain structure
Date: Wed, 20 Jan 2010 23:25:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001202325440.24456@utopia.booyaka.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com> <1264001442-20078-2-git-send-email-thara@ti.com> <1264001442-20078-3-git-send-email-thara@ti.com> <1264001442-20078-4-git-send-email-thara@ti.com> <1264001442-20078-5-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37286 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0AUGZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 01:25:55 -0500
In-Reply-To: <1264001442-20078-5-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, 20 Jan 2010, Thara Gopinath wrote:

> This patch adds the flag .pwrsts_logic_ret info for the core power domain
> in the associated powerdomain structure. This flag specifies the states
> core domain logic can hit in event of the domain entering retention.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>

Looks fine to me,


- Paul
