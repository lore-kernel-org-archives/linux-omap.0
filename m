From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC v2 11/18] ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3
Date: Tue, 8 Jan 2013 20:42:44 +0530
Message-ID: <50EC376C.2020809@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com> <1356959231-17335-12-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39778 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756325Ab3AHPLt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 10:11:49 -0500
In-Reply-To: <1356959231-17335-12-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> Since AM33XX supports only DT-boot, this is needed
> for the appropriate device nodes to be created.
>
> Note: OCMC RAM is part of the PER power domain and supports
> retention. The assembly code for low power entry/exit will
> run from OCMC RAM. To ensure that the OMAP PM code does not
> attempt to disable the clock to OCMC RAM as part of the
> suspend process add the no_idle_on_suspend flag.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
Looks fine to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

