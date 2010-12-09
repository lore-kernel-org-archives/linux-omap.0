From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] MFD: TWL/TPS: fix twl_probe section mismatch warning
 in mfd/twl-core.c
Date: Thu, 9 Dec 2010 15:59:59 +0100
Message-ID: <20101209145958.GN8884@sortiz-mobl>
References: <1291776124-9570-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65298 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753911Ab0LIPAD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 10:00:03 -0500
Content-Disposition: inline
In-Reply-To: <1291776124-9570-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org

Hi Bryan,

On Wed, Dec 08, 2010 at 10:42:04AM +0800, Bryan Wu wrote:
> Fix the following section mismatch warning when building omap2plus_defconfig:
> 
> WARNING: vmlinux.o(.data+0x47d7c): Section mismatch in reference from the variable twl_driver to the function .init.text:twl_probe()
> 
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
