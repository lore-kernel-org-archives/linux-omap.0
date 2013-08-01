From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [net-next PATCH 1/1] drivers: net: cpsw: Add support for new
 CPSW IP version
Date: Thu, 1 Aug 2013 06:43:48 +0200
Message-ID: <20130801044348.GA4846@netboy>
References: <20130731184525.GA629@radagast>
 <20130731192229.GB8027@netboy>
 <20130731194332.GA900@radagast>
 <20130731194523.GB900@radagast>
 <20130731200428.GD8027@netboy>
 <20130731200756.GA3737@radagast>
 <20130731202006.GE8027@netboy>
 <20130731202617.GB3737@radagast>
 <20130731203406.GF8027@netboy>
 <20130731211100.GC3737@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:61180 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab3HAEoG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Aug 2013 00:44:06 -0400
Content-Disposition: inline
In-Reply-To: <20130731211100.GC3737@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, netdev@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org

On Thu, Aug 01, 2013 at 12:11:00AM +0300, Felipe Balbi wrote:
> 
> that's the point, there is no known V3. Once it has, surely we will add
> such macros, but until then, we let the driver assume the highest known
> revision if it finds a register with an unknown revision.

I am confused. The patch description says

   The new IP version has a minor changes and the offsets are same as the previous
   version,

but you are saying there is no new version?

Thanks,
Richard

