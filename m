From: Greg KH <greg@kroah.com>
Subject: Re: Staging: Westbridge: fix EXPORT_SYMBOL errors reported by
 checkpatch.pl
Date: Fri, 21 Jan 2011 12:40:13 -0800
Message-ID: <20110121204012.GA28267@kroah.com>
References: <444938.26253.qm@web121610.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <444938.26253.qm@web121610.mail.ne1.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sutharsan Ramamoorthy <sutharsan.ramamoorthy@yahoo.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, david.cross@cypress.com, srmt@cypress.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 19, 2011 at 05:31:46PM -0800, Sutharsan Ramamoorthy wrote:
> From: Sutharsan Ramamoorthy <srmt@cypress.com>
> 
> This patch fixes errors in westbridge device controller driver in the 
> staging tree reported by checkpatch.pl. File containing EXPORT_SYMBOL() 
> macros for all the APIs exported by the westbridge software has been removed. EXPORT_SYMBOL() macros are added after the corresponding function definitions.
> 
> Signed-off-by: Sutharsan Ramamoorthy <srmt@cypress.com>

This patch is corrupted and can't be applied.  Perhaps it's due to the
mime encoding?

Anyway, care to fix your email client and resend it so that I can apply
it?

thanks,

greg k-h
