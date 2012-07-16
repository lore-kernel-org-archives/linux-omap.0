From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod: Disable module when hwmod enable
 fails
Date: Sun, 15 Jul 2012 18:10:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207151810170.28834@utopia.booyaka.com>
References: <1341580892-1028-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36508 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab2GPAK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Jul 2012 20:10:29 -0400
In-Reply-To: <1341580892-1028-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Fri, 6 Jul 2012, Rajendra Nayak wrote:

> From: Misael Lopez Cruz <misael.lopez@ti.com>
> 
> Clock and module mode are explictly enable when hwmod is enabled. But if
> the hwmod doesn't get ready on time, clocks are disabled but module is left
> enabled.
> 
> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

Thanks, queued for 3.6-rc.

- Paul
