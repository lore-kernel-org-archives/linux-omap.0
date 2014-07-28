From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/2] ARM: DRA7: hwmod: Add dra74x and dra72x specific
 ocp interface lists
Date: Mon, 28 Jul 2014 05:31:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407280530090.24161@utopia.booyaka.com>
References: <1406523237-6905-1-git-send-email-lokeshvutla@ti.com> <1406523237-6905-3-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52595 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbaG1Fbo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jul 2014 01:31:44 -0400
In-Reply-To: <1406523237-6905-3-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, nm@ti.com, nsekhar@ti.com, s-anna@ti.com

On Mon, 28 Jul 2014, Lokesh Vutla wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> To deal with IPs which are specific to dra74x and dra72x, maintain seperate
> ocp interface lists, while keeping the common list for all common IPs.
> 
> Move USB OTG SS4 to dra74x only list since its unavailable in
> dra72x and is giving an abort during boot. The dra72x only list
> is empty for now and a placeholder for future hwmod additions which
> are specific to dra72x.
> 
> Fixes: d904b38df0db13 ("ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss")
> Reported-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Tested-by: Nishanth Menon <nm@ti.com>

Queued with a fix for the comment style - i.e.,

+       if (ois[0] == NULL) /* Empty list */

rather than 

+       if (ois[0] == NULL) /* Empty list*/

Please keep an eye out for this.


- Paul
