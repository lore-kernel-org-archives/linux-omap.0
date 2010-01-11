From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] Regulator: Removing the common supplies and
 regulator init data structs
Date: Mon, 11 Jan 2010 11:18:08 +0000
Message-ID: <20100111111807.GC20717@rakim.wolfsonmicro.main>
References: <1262973473-32533-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51336 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751496Ab0AKLSJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 06:18:09 -0500
Content-Disposition: inline
In-Reply-To: <1262973473-32533-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Fri, Jan 08, 2010 at 11:27:53PM +0530, Anuj Aggarwal wrote:
> Removing the common supplies and regulator init data structs for various
> OMAP3 platforms. They all have been moved to a common TWL4030 specific file
> and will be referenced from there.

> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>

I'd expect this to be combined with the patch adding the usage of the
shared definitions so that the substitution that's being done is a bit
clearer.
