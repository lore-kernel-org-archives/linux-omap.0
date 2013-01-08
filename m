From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC v2 17/18] ARM: OMAP2+: AM33XX: Select Mailbox when PM is
 enabled
Date: Tue, 8 Jan 2013 20:52:37 +0530
Message-ID: <50EC39BD.2020204@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com> <1356959231-17335-18-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40266 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756569Ab3AHPVn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 10:21:43 -0500
In-Reply-To: <1356959231-17335-18-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> PM services on AM33XX depend on mailbox for communication
> with WKUP-M3 core so ensure that the right config options
> are selected. Thanks to Kevin Hilman <khilman@deeprootsystems.com>
> for the suggestion on updating the Kconfig and not just
> the omap2plus_defconfig which was done in the previous version
> of the AM33XX suspend-resume support.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Tony Lingren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
Unrelated to series. You can post this patch separately.

regards
Santosh

