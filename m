From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: fix build when CONFIG_REGULATOR_DUMMY=n
Date: Mon, 11 Oct 2010 19:11:08 +0100
Message-ID: <20101011181108.GA22355@opensource.wolfsonmicro.com>
References: <1286814955-23415-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44051 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755793Ab0JKSLK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Oct 2010 14:11:10 -0400
Content-Disposition: inline
In-Reply-To: <1286814955-23415-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>

On Mon, Oct 11, 2010 at 10:05:55PM +0530, Anand Gadiyar wrote:
> Commit f03f91826 (regulator: Add option for machine drivers
> to enable the dummy regulator) in the regulators tree
> seems to have introduced the following build break when
> CONFIG_REGULATOR_DUMMY is disabled. Fix this.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
