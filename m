From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC v2 10/18] ARM: OMAP2+: AM33XX: Update the hardreset API
Date: Tue, 8 Jan 2013 20:40:36 +0530
Message-ID: <50EC36EC.1020003@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com> <1356959231-17335-11-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37350 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756321Ab3AHPJo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 10:09:44 -0500
In-Reply-To: <1356959231-17335-11-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> WKUP-M3 has a reset status bit (RM_WKUP_STST.WKUP_M3_LRST)
> Update the hardreset API to ensure that the reset line properly
> deasserted.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
Looks good.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

