From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 02/14] ARM: OMAP: counter-32k: Select the CR register
 offset using the IP scheme.
Date: Mon, 9 Jul 2012 18:21:45 -0500
Message-ID: <4FFB6789.2000100@ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com> <1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com> <873950x4ng.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44726 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab2GIXVx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 19:21:53 -0400
In-Reply-To: <873950x4ng.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On 07/09/2012 11:47 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> OMAP socs has a legacy and a highlander version of the
>> 32k sync counter IP. The register offsets vary between the
>> highlander and the legacy scheme. So use the 'SCHEME'
>> bits(30-31) of the revision register to distinguish between
>> the two versions and choose the CR register offset accordingly.
> 
> Do these scheme bits exist on *all* OMAPs?  including OMAP1?
> 
> This driver is used on OMAP1 as well as OMAP2+.  
> 
> The cover letter says this was only build tested on OMAP1 so I suggest
> this actually be tested on OMAP1 before merging.

I have tested this on an omap5912 osk. I booted and verified that the
offset is good.

Santosh, add my tested-by for OMAP1 ...

Tested-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
