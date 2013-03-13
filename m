From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.9-rc1
Date: Wed, 13 Mar 2013 10:22:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303131020270.32131@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com> <51402BE9.5040402@compulab.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40417 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224Ab3CMKWS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 06:22:18 -0400
In-Reply-To: <51402BE9.5040402@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Igor,

On Wed, 13 Mar 2013, Igor Grinberg wrote:

> This should have been fixed by:
> ff95793 (ARM: OMAP3: cm-t3517: add MMC support)
> 
> I also can't find the MMC rootfs boot log on your website.

Hmm, I thought I had switched the CM-T3517 over to use MMC booting, but 
looks like it's still trying to use nfsroot.  Thanks for letting me know.  
Will switch to MMC and try again.


- Paul
