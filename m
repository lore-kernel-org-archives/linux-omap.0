From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in next with filesystem context concept
Date: Fri, 7 Sep 2018 09:10:23 -0700
Message-ID: <20180907161023.GF5662@atomide.com>
References: <20180906164358.GI5659@atomide.com>
 <9053.1536310046@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9053.1536310046@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

* David Howells <dhowells@redhat.com> [180907 08:51]:
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > Looks like next-20180906 now has a regression where mounting
> > root won't work with commit fd0002870b45 ("vfs: Implement a
> > filesystem superblock creation/configuration context").
> 
> Am I right in thinking you're not using any of the LSMs?

Assuming LSM as in Documentation/lsm.txt, right not using any.

BTW, I don't think this issue shows up with ramdisk either,
so that's probably why for example kernelci.org does not
show errors.

Regards,

Tony
