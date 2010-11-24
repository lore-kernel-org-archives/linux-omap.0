From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Return proper error for omap3pandora_soc_init
Date: Wed, 24 Nov 2010 11:30:51 +0000
Message-ID: <20101124113049.GA27020@rakim.wolfsonmicro.main>
References: <1290583248.20639.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39268 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752987Ab0KXLay (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 06:30:54 -0500
Content-Disposition: inline
In-Reply-To: <1290583248.20639.1.camel@mola>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-omap@vger.kernel.org

On Wed, Nov 24, 2010 at 03:20:48PM +0800, Axel Lin wrote:
> Return PTR_ERR(omap3pandora_dac_reg) instead of 0 if regulator_get failed.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
