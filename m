From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: zoom: host should not pull up wl1271's irq line
Date: Mon, 14 Mar 2011 11:12:59 -0700
Message-ID: <20110314181259.GF7258@atomide.com>
References: <1300112665-6253-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24140 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab1CNSNK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 14:13:10 -0400
Content-Disposition: inline
In-Reply-To: <1300112665-6253-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [110314 07:29]:
> The wl1271's irq line is completely controlled by the 1271 device, and
> the host does not not need to pull it up.
> 
> While there's no functional effect, letting the host pull this line up is
> just redundant, and wastes power.

Applying.

Tony
