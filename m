From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1]  ASoC: AIC23: Fixing writes to non-existing
 registers in resume function
Date: Fri, 29 Jan 2010 13:44:06 +0000
Message-ID: <20100129134406.GA4768@rakim.wolfsonmicro.main>
References: <1264753735-7190-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45323 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755158Ab0A2NoJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jan 2010 08:44:09 -0500
Content-Disposition: inline
In-Reply-To: <1264753735-7190-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Fri, Jan 29, 2010 at 01:58:55PM +0530, Anuj Aggarwal wrote:
> Commit e9ff5eb2 (Fixing infinite loop in resume path) uses wrong AIC23
> register in resume function because of which register writes happen
> on some non-existing registers.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>

Applied, thanks.
