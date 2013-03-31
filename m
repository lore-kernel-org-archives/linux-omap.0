From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from
 the driver
Date: Sun, 31 Mar 2013 01:39:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303310136490.6436@utopia.booyaka.com>
References: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35894 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab3CaBjK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Mar 2013 21:39:10 -0400
In-Reply-To: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

Hi

On Wed, 20 Feb 2013, Santosh Shilimkar wrote:

> UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
> so remove the hackery from the driver.
> 
> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Rajendra nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

I'm fine with the basic idea.  But based on rmk's and your 
subsequent comments, please add some comments to the driver in this patch 
that encapsulates what needs to be done to get DMA working again properly, 
including the idle mode switching, in the unlikely event that someone will 
try to get that working again.


- Paul
