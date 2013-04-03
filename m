From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP/serial: Revert bad fix of Rx FIFO threshold
 granularity
Date: Wed, 3 Apr 2013 20:16:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304032015050.16711@utopia.booyaka.com>
References: <20130403183146.GA4072@inertiallabs-linux64>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59228 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762609Ab3DCUQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 16:16:19 -0400
In-Reply-To: <20130403183146.GA4072@inertiallabs-linux64>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Greg, Alexey,

On Wed, 3 Apr 2013, Alexey Pelykh wrote:

> From: Alexey Pelykh <alexey.pelykh@gmail.com>
> 
> Partially reverts 1776fd059c40907297d6c26c51876575d63fd9e2
> that introduced regression reported by Paul Walmsley.
> 
> This commit restores setting granularity in SCR register
> and adds note about comments below being inconsistent with
> actual code.
> 
> Signed-off-by: Alexey Pelykh <alexey.pelykh@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-serial@vger.kernel.org 
> Cc: linux-arm-kernel@lists.infradead.org 
> Cc: linux-omap@vger.kernel.org 

Tested-by: Paul Walmsley <paul@pwsan.com>

Thanks for the fast response and fix, Alexey.

Greg, is it possible for you to take this for v3.9-rc fixes?


- Paul
