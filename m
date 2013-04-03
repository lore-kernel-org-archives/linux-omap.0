From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] OMAP/serial: Revert bad fix of Rx FIFO threshold
 granularity
Date: Wed, 3 Apr 2013 13:24:57 -0700
Message-ID: <20130403202457.GA19668@kroah.com>
References: <20130403183146.GA4072@inertiallabs-linux64>
 <alpine.DEB.2.00.1304032015050.16711@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1304032015050.16711@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Alexey Pelykh <alexey.pelykh@gmail.com>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 03, 2013 at 08:16:18PM +0000, Paul Walmsley wrote:
> Hi Greg, Alexey,
> 
> On Wed, 3 Apr 2013, Alexey Pelykh wrote:
> 
> > From: Alexey Pelykh <alexey.pelykh@gmail.com>
> > 
> > Partially reverts 1776fd059c40907297d6c26c51876575d63fd9e2
> > that introduced regression reported by Paul Walmsley.
> > 
> > This commit restores setting granularity in SCR register
> > and adds note about comments below being inconsistent with
> > actual code.
> > 
> > Signed-off-by: Alexey Pelykh <alexey.pelykh@gmail.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@linaro.org>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: linux-serial@vger.kernel.org 
> > Cc: linux-arm-kernel@lists.infradead.org 
> > Cc: linux-omap@vger.kernel.org 
> 
> Tested-by: Paul Walmsley <paul@pwsan.com>
> 
> Thanks for the fast response and fix, Alexey.
> 
> Greg, is it possible for you to take this for v3.9-rc fixes?

Will do, thanks.

greg k-h
