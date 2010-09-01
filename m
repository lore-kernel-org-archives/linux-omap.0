From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] OMAP: hwmod: Force a softreset during _setup
Date: Wed, 1 Sep 2010 16:51:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009011645410.23624@utopia.booyaka.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com> <1280959968-23933-4-git-send-email-b-cousson@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301E81E9434@dbde02.ent.ti.com> <4C6BF591.1010007@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301E82ACD94@dbde02.ent.ti.com>
 <4C727E3F.7060502@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34342 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab0IAWvl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 18:51:41 -0400
In-Reply-To: <4C727E3F.7060502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Basak, Partha" <p-basak2@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

On Mon, 23 Aug 2010, Cousson, Benoit wrote:

> Here is a small patch that should fix that issue:
> The approach is quite basic, I'm just enabling all the optional clocks if the
> flag is set.
> 
> Could you give it a try?

This approach seems good.  Maybe we should add a flags field in 
struct omap_hwmod_opt_clks to indicate that a particular clock needs to be 
enabled during the reset process?  That way the specific clocks that are 
necessary can be enabled, rather than all of the clocks.

One other general comment on an earlier part of this discussion: the goal 
is to reset almost every module during boot: this is to clear any bogus 
configurations that the bootloader may have written to the hardware.  The 
goal is to have a consistent, known hardware configuration in the kernel, 
independent of the bootloader.

Partha, does this patch work for you?

- Paul
