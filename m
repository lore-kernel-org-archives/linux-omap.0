From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/5] pdev: Fix platform device resource linking
Date: Tue, 6 Aug 2013 17:36:01 +0800
Message-ID: <20130806093601.GB27889@kroah.com>
References: <1375775624-12250-1-git-send-email-panto@antoniou-consulting.com>
 <1375775624-12250-2-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1375775624-12250-2-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, =?iso-8859-1?Q?Beno=EEt?= Coussno <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Sourav Poddar <sourav.poddar@ti.com>, Russ Dill <Russ.Dill@ti.com>, Felipe Balbi <balbi@ti.com>, Koen Kooi <koen@circuitco.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 06, 2013 at 10:53:40AM +0300, Pantelis Antoniou wrote:
> Platform device removal uncovered a number of problems with
> the way resources are handled in the core platform code.
> 
> Resources now form child/parent linkages and this requires
> proper linking of the resources. On top of that the OF core
> directly creates it's own platform devices. Simplify things
> by providing helper functions that manage the linking properly.

Ugh, the OF core shouldn't be creating platform devices.  Well, yes, I
know it does that today, but ick, ick, ick.

> Two functions are provided:
> 
> platform_device_link_resources(), which links all the
> linkable resources (if not already linked).
> 
> and platform_device_unlink_resources(), which unlinks all the
> resources.

Why would anyone need to call this?  I'm getting the feeling that OF
should just have it's own bus of devices to handle this type of mess.
ACPI is going through the same rewrite for this same type of problem
(they did things differently.)  I suggest you work with the ACPI
developers to so the same thing they are, to solve it correctly for
everyone.

thanks,

greg k-h
