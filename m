From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC v2 08/18] ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod
 entry
Date: Tue, 8 Jan 2013 20:38:14 +0530
Message-ID: <50EC365E.70202@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com> <1356959231-17335-9-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39501 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756332Ab3AHPHW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 10:07:22 -0500
In-Reply-To: <1356959231-17335-9-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> The current HWMOD code expects the memory region with
> the IP's SYSCONFIG register to be marked with ADDR_TYPE_RT
> flag.
>
> CPGMAC0 hwmod entry specifies two memory regions and marks
> both with the flag ADDR_TYPE_RT although only the 2nd region
> has the SYSCONFIG register. This leads to the HWMOD code
> accessing the wrong memory address for idle and standby
> operations. Fix this by removing the ADDR_TYPE_RT flag from
> the 1st memory region in CPGMAC0 hwmod entry.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
Seems correct to me though Benoit, Paul can
may have comment.

Regards
Santosh

