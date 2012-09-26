From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/3] uio: uio_pruss: port to AM33xx
Date: Wed, 26 Sep 2012 14:10:19 -0700
Message-ID: <20120926211019.GB16674@kroah.com>
References: <1348667071-12631-1-git-send-email-mporter@ti.com>
 <1348667071-12631-2-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1348667071-12631-2-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: "Hans J. Koch" <hjk@hansjkoch.de>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 26, 2012 at 09:44:29AM -0400, Matt Porter wrote:
> Add ifdefery hacks to only use SRAM on Davinci. This
> needs to be cleaned up with a sane generic SRAM allocator
> (like the DT based driver available that can't be used on
> Davinci which is just starting DT conversion) before it
> can go upstream.
> 
> Adds DT, pinctrl, and runtime PM support for use on
> AM33xx.

Ick, that's really messy, no other way to do this in a "cleaner"
fashion?

greg k-h
