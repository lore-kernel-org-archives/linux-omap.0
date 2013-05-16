From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 0/6] ARM: OMAP2+: hwmod and SERIAL: Remove sysc handling
 from driver
Date: Thu, 16 May 2013 18:32:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1305161831390.21357@utopia.booyaka.com>
References: <1368629322-3170-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46287 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab3EPSco (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 14:32:44 -0400
In-Reply-To: <1368629322-3170-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, nm@ti.com

On Wed, 15 May 2013, Rajendra Nayak wrote:

> OMAP UART IP needs manual idle modes based on functional state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.
> 
> This however breaks in case of device tree because of missing
> idle handling. 
> 
> The series tries to address the issue and tries to remove complete
> sysc handling from serial driver.

These look good to me.  Will queue them for v3.10-rc once they pass local 
testing here.


- Paul
