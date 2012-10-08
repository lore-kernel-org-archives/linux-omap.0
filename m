From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] AM35xx: Add missing hwmod entry for the HDQ/1-Wire
 present in AM3505/3517 CPUs.
Date: Mon, 8 Oct 2012 14:11:11 -0700
Message-ID: <20121008211110.GI13011@atomide.com>
References: <20120917145614.GD22993@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29208 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754710Ab2JHVLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 17:11:13 -0400
Content-Disposition: inline
In-Reply-To: <20120917145614.GD22993@renkinjitsu.usine.8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raphael Assenat <raph@8d.com>
Cc: linux-omap@vger.kernel.org

* Raphael Assenat <raph@8d.com> [120917 07:57]:
> This patch adds a missing hwmod entry for the HDQ/1-Wire module present 
> in the AM3505/17 CPUs.
> 
> This restores 1-Wire support to our AM3505 boards. We think it probably
> stopped working with commit 96b1b29d37b0ca3ecd424a1fe301406cf525fc04
> ARM: OMAP2+: HDQ1W: use omap_device

Thanks applying into fixes.

Tony
