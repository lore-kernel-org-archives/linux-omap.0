From: Greg KH <greg@kroah.com>
Subject: Re: Staging: Westbridge: fix EXPORT_SYMBOL errors reported by
 checkpatch.pl
Date: Mon, 31 Jan 2011 13:31:40 -0800
Message-ID: <20110131213140.GA1671@kroah.com>
References: <1296018202.3623.24.camel@sutharsan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1296018202.3623.24.camel@sutharsan-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Sutharsan <sutharsan.tech@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, david.cross@cypress.com, srmt@cypress.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 25, 2011 at 09:03:22PM -0800, Sutharsan wrote:
> From: Sutharsan Ramamoorthy <srmt@cypress.com>
> 
> This patch fixes errors reported by checkpatch.pl 
> in westbridge device controller driver in the staging tree.
> File containing EXPORT_SYMBOL() macros for all the APIs exported 
> by the westbridge software has been removed. EXPORT_SYMBOL() 
> macros are added after the corresponding function definitions.
> 
> Signed-off-by: Sutharsan Ramamoorthy <srmt@cypress.com>

I've already applied this patch, and you should have gotten the "this
patch has been applied" email, right?

So why was it resent?

confused,

greg k-h
