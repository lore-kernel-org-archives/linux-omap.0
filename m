From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Removes FIXME message in usb.c
Date: Wed, 9 Jul 2014 10:19:30 -0700
Message-ID: <20140709171930.GA11527@kroah.com>
References: <1404924948-3298-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404924948-3298-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: balbi@ti.com, tony@atomide.com, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Ok, this has been fun to watch on lkml for a while now, but really,
please, just stop doing this.  Randomly searching the kernel source for
FIXME lines and just commenting them out, isn't ok.  Almost always,
those lines are there because the original developer really doesn't know
how else to resolve the issue.

So, if the domain-specific-author doesn't have an idea of what to do,
how does someone who is brand-new to the code know better?

If you are looking for a task to do in the kernel, try
drivers/staging/*/TODO for a list.  Or look at the kernel janitor's list
on kernelnewbies.org.  Or try running the kernel and finding something
that is broken for you and fixing that.  Any of those would be better
than randomly deleting FIXME lines.  By doing that, you are just wasting
maintainer's time.  Which is the resource we have the least of at the
moment.

thanks,

greg k-h
