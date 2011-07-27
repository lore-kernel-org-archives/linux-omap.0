From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCHv2] mfd: twl4030: Fix mismatch in mutex lock-unlock
Date: Wed, 27 Jul 2011 12:55:45 +0200
Message-ID: <20110727105545.GG26275@sortiz-mobl>
References: <1310397631-1596-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:57050 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555Ab1G0Kyd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jul 2011 06:54:33 -0400
Content-Disposition: inline
In-Reply-To: <1310397631-1596-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>

Hi Premi,

On Mon, Jul 11, 2011 at 08:50:31PM +0530, Sanjeev Premi wrote:
> A mutex is locked on entry into twl4030_madc_conversion().
> Immediate return on some error conditions leaves the
> mutex locked.
> 
> This patch ensures that mutex is always unlocked before
> leaving the function.
Patch applied, many thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
