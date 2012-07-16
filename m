From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 5/6] ARM: OMAP3: hwmod data: add sad2d hwmod
Date: Sun, 15 Jul 2012 19:14:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207151812590.28834@utopia.booyaka.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com> <1342197459-7920-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58603 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab2GPBOH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Jul 2012 21:14:07 -0400
In-Reply-To: <1342197459-7920-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 13 Jul 2012, Tero Kristo wrote:

> SAD2D stands for the die to die interface, and is used for communicating
> with the optional stacked modem. This hwmod is added in preparation for
> the d2d_idle move from pm34xx.c to hwmod data.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, queued this for 3.7.


- Paul
