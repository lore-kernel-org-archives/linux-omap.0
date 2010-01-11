From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/6] Regulator: Removing common code for TWL4030 PMIC
 from various OMAP3 board-evms
Date: Mon, 11 Jan 2010 11:16:13 +0000
Message-ID: <20100111111612.GB20717@rakim.wolfsonmicro.main>
References: <1262973448-32439-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51331 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751870Ab0AKLQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 06:16:15 -0500
Content-Disposition: inline
In-Reply-To: <1262973448-32439-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Fri, Jan 08, 2010 at 11:27:28PM +0530, Anuj Aggarwal wrote:
> Based on the discussions and feedback received, this patch set is
> created which cleans up various OMAP3-board-evm files and removes
> common TWL4030 specific regulator suuplies and init data structs.

Please use an OMAP-specific subject line for this patch series - there's
no generic regulator changes in here, it's all OMAP-specific.  This
helps with scanning inboxes and mailing list folders.
