From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Staging: Westbridge: replace custom debug macros with
 pr_...() macros
Date: Thu, 28 Apr 2011 12:47:25 -0700
Message-ID: <20110428194725.GB25302@kroah.com>
References: <1304016521.3749.13.camel@sutharsan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1304016521.3749.13.camel@sutharsan-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Sutharsan <sutharsan.tech@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, david.cross@cypress.com, srmt@cypress.com
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 28, 2011 at 11:48:41AM -0700, Sutharsan wrote:
> >From Sutharsan Ramamoorthy <srmt@cypress.com>
> 
> This patch replaces custom debug macros with Linux kernel's pr_...() macros.

Why not use the dev_dbg() and other macros instead of these?  You do
have access to a struct device for all of these places in the code,
right?

thanks,

greg k-h
