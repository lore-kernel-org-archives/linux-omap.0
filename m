From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates for
 3.10
Date: Wed, 3 Apr 2013 20:09:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304031953010.16711@utopia.booyaka.com>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59178 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762520Ab3DCUJc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 16:09:32 -0400
In-Reply-To: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

cc Kevin

Hi

On Wed, 20 Mar 2013, Santosh Shilimkar wrote:

> Benoit Cousson (7):
>       ARM: OMAP5: PRM: Add OMAP54XX register and bitfield files

So it looks like this patch never made it to the mailing list.  Was it too 
big?  If so, please try splitting it into two or more pieces.  Looking at 
the git branch that you posted for pulling, the patch adds two files, so 
maybe you can just create one patch for each file?

Also, looking at the bottom of the arch/arm/mach-omap2/prm54xx.h from this 
commit 600e78bb51c0ee081f0da14f879c3e4a1dee9896, there are a bunch of 
function prototypes that reference OMAP44xx.  Shouldn't these reference 
OMAP54xx, or be removed from this file?  If you're reusing the OMAP4 PRM 
functions for OMAP5, then shouldn't they be moved out from the OMAP4 
header files into a separate header file?

>       ARM: OMAP5: CM: Add OMAP54XX register and bitfield files

There are similar problems with this patch.  It doesn't look like it ever 
made it to the linux-omap list, in my inbox, anyway.  And again the 
function prototypes make several references to OMAP4, when they should 
refer to OMAP5 or be removed from this file.

>       ARM: OMAP5: PRCM: Add OMAP54XX local MPU PRCM registers

More duplicated OMAP4 function prototypes here.

>       ARM: OMAP5: SCRM: Add OMAP54XX header file.

Looks fine to me.

>       ARM: OMAP2+: clockdomain data: Add OMAP54XX data and update the header
>       ARM: OMAP5: powerdomain data: Add OMAP54XX data and update the header

These two look okay to me based on a superficial inspection.  Is there a 
public TRM posted for OMAP5?  It's not in the obvious place, so there's no 
way to review these against the TRM:

http://www.ti.com/lsds/ti/omap-applications-processors/technical-documents.page?familyId=601&docCategoryId=6

>       ARM: OMAP5: hwmod data: Create initial OMAP5 SOC hwmod data

Looks like this one hasn't been reposted after the changes that were made 
to it after Tony's comments?  If I've just missed the list post, please 
send a link.  Otherwise, the updated patch should be reposted.

> Santosh Shilimkar (4):
>       ARM: OMAP5: hwmod_data: Fix UART sysc settings
>       ARM: OMAP5: hwmod-data: Add timer clock activity flags

These two should be rolled into the "ARM: OMAP5: hwmod data: Create 
initial OMAP5 SOC hwmod data" patch.

>       ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data

This one needs to be acked by Kevin.

>       ARM: OMAP5: Enable build and frameowrk initialisations

Looks fine to me.


- Paul
