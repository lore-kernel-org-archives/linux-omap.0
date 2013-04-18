From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [RFC PATCH v2 1/4] retu-mfd: support also Tahvo
Date: Fri, 19 Apr 2013 00:46:05 +0200
Message-ID: <20130418224605.GE8798@zurbaran>
References: <1365537088-23199-1-git-send-email-aaro.koskinen@iki.fi>
 <1365537088-23199-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44888 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966948Ab3DRWqL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Apr 2013 18:46:11 -0400
Content-Disposition: inline
In-Reply-To: <1365537088-23199-2-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Hi Aaro,

On Tue, Apr 09, 2013 at 10:51:25PM +0300, Aaro Koskinen wrote:
> Tahvo is a multi-function device on Nokia 770, implementing USB
> transceiver and charge/battery control.
> 
> It's so close to Retu that a single driver can support both.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/Kconfig      |    6 ++--
>  drivers/mfd/retu-mfd.c   |   85 ++++++++++++++++++++++++++++++++++++++++------
>  include/linux/mfd/retu.h |    8 ++++-
>  3 files changed, 85 insertions(+), 14 deletions(-)
Simple and good enough, I applied this one.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
