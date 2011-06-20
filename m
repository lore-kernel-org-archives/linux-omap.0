From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] mfd: omap: fix the crash during omap ehci or ohci driver
 initialization
Date: Mon, 20 Jun 2011 15:26:26 +0200
Message-ID: <20110620132626.GJ22420@sortiz-mobl>
References: <1307367739-20110-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60635 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100Ab1FTN0T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jun 2011 09:26:19 -0400
Content-Disposition: inline
In-Reply-To: <1307367739-20110-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, parthab@india.ti.com

Hi Keshava,

On Mon, Jun 06, 2011 at 07:12:19PM +0530, Keshava Munegowda wrote:
> From: Keshava Munegowda <Keshava_mgowda@ti.com>
> 
> Oops are produced during initialization of ehci and ohci
> drivers. This is because the run time pm apis are used by
> the driver but the corresponding hwmod structures and
> initialization is not merged. 
You mean they're currently checked in a different tree ? Is that a public one?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
