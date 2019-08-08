From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kernfs: fix memleak in kernel_ops_readdir()
Date: Thu, 8 Aug 2019 08:42:35 +0200
Message-ID: <20190808064235.GC26197@kroah.com>
References: <20190805173404.GF136335@devbig004.ftw2.facebook.com>
 <20190807132928.GD5443@atomide.com>
 <20190807184518.GP136335@devbig004.ftw2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190807184518.GP136335@devbig004.ftw2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 07, 2019 at 11:45:18AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 07, 2019 at 06:29:28AM -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > * Tejun Heo <tj@kernel.org> [691231 23:00]:
> > > From: Andrea Arcangeli <aarcange@redhat.com>
> > > 
> > > If getdents64 is killed or hits on segfault, it'll leave cgroups
> > > directories in sysfs pinned leaking memory because the kernfs node
> > > won't be freed on rmdir and the parent neither.
> > 
> > Somehow this causes a regression in Linux next for me where I'm seeing
> > lots of sysfs entries now missing under /sys/bus/platform/devices.
> > 
> > For example, I now only see one .serial entry show up in sysfs.
> > Things work again if I revert commit cc798c83898e ("kernfs: fix memleak
> > inkernel_ops_readdir()"). Any ideas why that would be?
> > 
> > Below is a diff -u of ls /sys/bus/platform/devices for reference
> > showing the missing entries with cc798c83898e.
> 
> Ugh, you're right.  It can get double-put cuz ctx->pos is put by
> release too.  Greg, sorry about the noise but can you please revert
> the patch?  I'll look into why this looked like memory leak from
> slabinfo side.

Now reverted, thanks.

greg k-h
