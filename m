From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [024/115] USB: prevent buggy hubs from crashing the USB stack
Date: Thu, 24 Feb 2011 19:11:34 +0100
Message-ID: <4D669F56.4020303@ahsoftware.de>
References: <Pine.LNX.4.44L0.1102241255100.2084-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1102241255100.2084-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, Greg KH <gregkh@suse.de>, Michael Jones <michael.jones@matrix-vision.de>, Kernel development list <linux-kernel@vger.kernel.org>, stable@kernel.org, stable-review@kernel.org, torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

Am 24.02.2011 18:57, schrieb Alan Stern:

> It's important that this patch appear in .37-stable at the same time as
> the $SUBJECT patch.  If that means delaying $SUBJECT for one release,
> so be it -- it was not a very important change.

Too late, 2.6.37.1 is already broken. But the patch could be still 
applied to 2.6.32-longterm, at least the message I've replied to asked 
about objections for that version.

Regards,

Alexander
