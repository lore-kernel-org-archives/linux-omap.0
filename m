From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC part1/2 merge v4][PATCH 00/11] omap2/3/4: uart4 fixes +
 zoom2/3 changes
Date: Fri, 12 Mar 2010 11:21:48 -0600
Message-ID: <A24693684029E5489D1D202277BE894453FB179F@dlee02.ent.ti.com>
References: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57306 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933544Ab0CLRWI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 12:22:08 -0500
In-Reply-To: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Aguirre, Sergio
Sent: Wednesday, March 10, 2010 6:14 PM
> Hi,
> 
> This is v4 of my serial work series merge found here: [1].
> 
> And it's meant to be applied on top of Thomas's patch: [2]
> 
> Changelog compared to previous version:
>  - Changed printk to dev_* macros (Thanks Felipe)
> 
> Please let me know your comments and thoughts.
> 
> Thanks to:
>  - Vikram Pandita
>  - Paul Walmsley
>  - Kevin Hilman
>  - Manjunath Kondaiah
>  - Felipe Balbi
> 
> For the feedback recieved so far. I really appreciate it.
> 
> Regards,
> Sergio

Tony,

Should I take out the new code, and just send you the fixes necessary to boot the zoom3, without adding uart4 support?

Or what do you recommend about this patchseries?

Regards,
Sergio

<snip>

> [1] http://marc.info/?l=linux-omap&m=126815136710361&w=2
> [2] http://marc.info/?l=linux-kernel&m=126709078514087&w=2
