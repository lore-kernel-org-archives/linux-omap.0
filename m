From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 04/14] ARM: OMAP2+: gpmc: minimal driver support
Date: Wed, 13 Jun 2012 06:29:17 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9988BA@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <54e643eb1b4dbefcbb52580fa582043bf4f0da3d.1339419492.git.afzal@ti.com>
 <4FD7963A.9000003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53023 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705Ab2FMG32 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 02:29:28 -0400
In-Reply-To: <4FD7963A.9000003@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Wed, Jun 13, 2012 at 00:49:22, Hunter, Jon wrote:
> On 06/11/2012 09:26 AM, Afzal Mohammed wrote:

> >  	clk_enable(gpmc_l3_clk);
> 
> We should be able to get rid of the clk_enable() here and use ...
> 
> 	pm_runtime_enable(&pdev->dev);
> 	pm_runtime_get(&pdev->dev);
> 
> The clk_disable should also be replaced with a pm_runtime_put(). You
> will also need to include pm_runtime.h.

Once driver conversion is in, it would be made rpm capable.

Regards
Afzal
