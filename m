From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [RFC PATCH v2 0/6] TI81XX: Add clock and hwmod data
Date: Thu, 15 Sep 2011 07:11:37 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4BF4747@dbde02.ent.ti.com>
References: <1314119594-22647-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1108301246170.26173@utopia.booyaka.com>
 <20110915003325.GD30941@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48977 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560Ab1IOBls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 21:41:48 -0400
In-Reply-To: <20110915003325.GD30941@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

Tony Lindgren wrote on Thursday, September 15, 2011 6:03 AM:

> * Paul Walmsley <paul@pwsan.com> [110830 11:13]:
>> On Tue, 23 Aug 2011, Hemant Pedanekar wrote:
>> 
>>> This patch set is the v2 of TI816X clock and hwmods patches sent earlier.
>>> 
>>> The clock data is currently added only for TI816X, while minimal hwmod
>>> data common for TI816X and TI814X is added.
>>> 
>>> This patch set depends on following patches:
>>> 	TI81XX: Prepare for addition of TI814X support
>>> 	TI814X: Add cpu type macros and detection support
>>> 	TI814X: Create board support and enable build for TI8148 EVM
>>> 
>>> Please note that CHIP_IS_TI816X/CHIP_IS_TI814X are still being used and I
>>> will send update once SoC list usage is available.
>> 
>> Thanks - am working away on these patches & hope to have them out soon.
> 
> Hemant, can you please rebase your patches on Paul's CHIP_IS removal branch?
> 
> It's available at:
> 
> git://git.pwsan.com/linux-2.6 omap_chip_remove_cleanup_3.2
> 
> Regards,
> 
> Tony

Thanks, I will do that and send v3.

   Hemant