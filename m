From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH] of: DMA helpers: manage generic requests specification
Date: Wed, 14 Mar 2012 12:16:16 -0600
Message-ID: <4F60E070.8040003@wwwdotorg.org>
References: <4F22DEF2.5000807@ti.com> <1330527248-4350-1-git-send-email-nicolas.ferre@atmel.com> <20120305153648.GG27229@ponder.secretlab.ca> <4F60D9BB.9060709@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:37619 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031017Ab2CNSQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 14:16:19 -0400
In-Reply-To: <4F60D9BB.9060709@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, swarren@nvidia.com, Russell King <linux@arm.linux.org.uk>, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/14/2012 11:47 AM, Nicolas Ferre wrote:
...
> I do have the will to avoid the treats of memory corruption in case of
> malformed DT data, as Stephen was saying. But, on the other hand I do
> not know really if this can happen: if the .xlate() function which is
> provided by the DMA controller is well written, it should check for
> proper args_count or maximum string size. I do not have the feeling that
> adding an enum will enforce the security here.
> 
> Do you know a way to enforce security of this "void *" parameter or the
> check of number of cells + the due diligence of .xlate() function
> writers will be enough?

I guess if the only source of the data is a driver's of_xlate function,
and it's only being passed back to that same driver and never
interpreted elsewhere, then its probably reasonable to assume that's
enough for safety.
