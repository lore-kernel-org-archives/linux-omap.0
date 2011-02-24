From: Greg KH <gregkh@suse.de>
Subject: Re: [024/115] USB: prevent buggy hubs from crashing the USB stack
Date: Thu, 24 Feb 2011 10:24:24 -0800
Message-ID: <20110224182424.GA19191@suse.de>
References: <Pine.LNX.4.44L0.1102241255100.2084-100000@iolanthe.rowland.org>
 <4D669F56.4020303@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D669F56.4020303@ahsoftware.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Michael Jones <michael.jones@matrix-vision.de>, Kernel development list <linux-kernel@vger.kernel.org>, stable@kernel.org, stable-review@kernel.org, torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 24, 2011 at 07:11:34PM +0100, Alexander Holler wrote:
> Hello,
> 
> Am 24.02.2011 18:57, schrieb Alan Stern:
> 
> >It's important that this patch appear in .37-stable at the same time as
> >the $SUBJECT patch.  If that means delaying $SUBJECT for one release,
> >so be it -- it was not a very important change.
> 
> Too late, 2.6.37.1 is already broken. But the patch could be still
> applied to 2.6.32-longterm, at least the message I've replied to
> asked about objections for that version.

It's too late for that release as well, as it's already included in the
last .32 stable release.  I'll revert it there also for now.

thanks,

greg k-h
