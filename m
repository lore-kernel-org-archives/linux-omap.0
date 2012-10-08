From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] AM35xx: Add missing hwmod entry for the HDQ/1-Wire
 present in AM3505/3517 CPUs.
Date: Mon, 8 Oct 2012 23:56:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210082356350.5736@utopia.booyaka.com>
References: <20120917145614.GD22993@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56138 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab2JHX4u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 19:56:50 -0400
In-Reply-To: <20120917145614.GD22993@renkinjitsu.usine.8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raphael Assenat <raph@8d.com>
Cc: linux-omap@vger.kernel.org

On Mon, 17 Sep 2012, Raphael Assenat wrote:

> This patch adds a missing hwmod entry for the HDQ/1-Wire module present 
> in the AM3505/17 CPUs.
> 
> This restores 1-Wire support to our AM3505 boards. We think it probably
> stopped working with commit 96b1b29d37b0ca3ecd424a1fe301406cf525fc04
> ARM: OMAP2+: HDQ1W: use omap_device
> 
> Signed-off-by: Raphael Assenat <raph@8d.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
