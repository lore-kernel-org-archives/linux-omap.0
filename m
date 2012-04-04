From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
Date: Wed, 4 Apr 2012 09:34:31 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204040934210.8000@utopia.booyaka.com>
References: <1331647435-31666-1-git-send-email-rnayak@ti.com> <1331647435-31666-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49752 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311Ab2DDPec (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 11:34:32 -0400
In-Reply-To: <1331647435-31666-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anand Gadiyar <gadiyar@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

On Tue, 13 Mar 2012, Rajendra Nayak wrote:

> omap_hwmod_softreset() does not seem to wait for reset status
> after doing a softreset. Make it use _ocp_softreset() instead
> which does this correctly.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Anand Gadiyar <gadiyar@ti.com>
> Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

Thanks, queued for 3.4-rc.


- Paul
