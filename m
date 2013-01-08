From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC v2 09/18] ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3
 hwmod with reset status bit
Date: Tue, 8 Jan 2013 20:39:37 +0530
Message-ID: <50EC36B1.3030704@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com> <1356959231-17335-10-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39585 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756299Ab3AHPIl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 10:08:41 -0500
In-Reply-To: <1356959231-17335-10-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Vaibhav,

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> WKUP-M3 has a reset status bit (RM_WKUP_STST.WKUP_M3_LRST)
> Update the WKUP-M3 hwmod data to reflect the same.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
I think you should make a separate series for
the data file updates/fixes.

Regards
Santosh

