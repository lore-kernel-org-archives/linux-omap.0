From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: Guidelines to move mach-omap2/gpmc to drivers/memory-controller
Date: Fri, 15 Feb 2013 14:08:08 -0600
Message-ID: <511E95A8.2090709@ti.com>
References: <20130215165840.GB2442@localhost> <alpine.DEB.2.00.1302151952410.19565@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55262 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729Ab3BOUIM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 15:08:12 -0500
In-Reply-To: <alpine.DEB.2.00.1302151952410.19565@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org


On 02/15/2013 01:53 PM, Paul Walmsley wrote:
> Hi,
> 
> On Fri, 15 Feb 2013, Ezequiel Garcia wrote:
> 
>> I imagine one of the biggest issues is GPMC's dependency on
>> hwmod code. Can anyone shed some light on how to handle this?
> 
> What dependency is this?  I'm not aware of any GPMC dependency to hwmod; 
> there shouldn't be any.

If Ezequiel is referring to the code in omap_gpmc_init() that is looking
up the hwmod struct for gpmc, then this not a dependency. This function
should remain in mach-omap2/gpmc.c and not be moved into drivers/.
Eventually once we have migrated to DT, this function will be removed
altogether.

Cheers
Jon
