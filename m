From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in next with filesystem context concept
Date: Mon, 10 Sep 2018 09:08:36 -0700
Message-ID: <20180910160836.GT5662@atomide.com>
References: <20180907161023.GF5662@atomide.com>
 <20180906164358.GI5659@atomide.com>
 <9053.1536310046@warthog.procyon.org.uk>
 <11959.1536420266@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11959.1536420266@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

* David Howells <dhowells@redhat.com> [180908 15:28]:
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > > > Looks like next-20180906 now has a regression where mounting
> > > > root won't work with commit fd0002870b45 ("vfs: Implement a
> > > > filesystem superblock creation/configuration context").
> > > 
> > > Am I right in thinking you're not using any of the LSMs?
> > 
> > Assuming LSM as in Documentation/lsm.txt, right not using any.
> 
> The default return value for security_fs_context_parse_param() should be
> -ENOPARAM, both in security.h and security.c.
> 
> I've fixed my tree and Al has pulled it, but we're now waiting on Stephen
> Rothwell to refresh linux/next.

OK thanks for tracking that down, next-20180910 boots again
for me.

Regards,

Tony
