From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [OMAPZOOM][PATCH]DSPBRIDGE: Change GFP_ATOMIC to GFP_KERNEL
Date: Thu, 22 Jan 2009 08:34:14 +0200 (EET)
Message-ID: <20090122.083414.188795203.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E60284C6C596@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22240 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755328AbZAVGeY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 01:34:24 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E60284C6C596@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com
Cc: linux-omap@vger.kernel.org, vikram.pandita@ti.com

Hi Fernando, 

From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [OMAPZOOM][PATCH]DSPBRIDGE: Change GFP_ATOMIC to GFP_KERNEL
Date: Wed, 21 Jan 2009 18:46:01 -0600

> 
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Wed, 21 Jan 2009 17:39:38 -0600
> Subject: [PATCH] BRIDGE: Change GFP_ATOMIC to GFP_KERNEL
> 
> This patch replace the memory allocations which use
> GFP_ATOMIC with GFP_KERNEL since the calls for memory
> allocation in dspbridge are not in interrupt context.
> 
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

You swapped "From:/Signed-off-by:" and "Acked-by:" name;-)
Would it be possible to send the updated one again?
Then, I'll put it on "tidspbridge" branch.

Thank you for your verification of this patch.

	Hiroshi DOYU
