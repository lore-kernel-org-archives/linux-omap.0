From: David Howells <dhowells@redhat.com>
Subject: Re: Regression in next with filesystem context concept
Date: Sat, 08 Sep 2018 16:24:26 +0100
Message-ID: <11959.1536420266@warthog.procyon.org.uk>
References: <20180907161023.GF5662@atomide.com> <20180906164358.GI5659@atomide.com> <9053.1536310046@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907161023.GF5662@atomide.com>
Content-ID: <11958.1536420266.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote:

> > > Looks like next-20180906 now has a regression where mounting
> > > root won't work with commit fd0002870b45 ("vfs: Implement a
> > > filesystem superblock creation/configuration context").
> > 
> > Am I right in thinking you're not using any of the LSMs?
> 
> Assuming LSM as in Documentation/lsm.txt, right not using any.

The default return value for security_fs_context_parse_param() should be
-ENOPARAM, both in security.h and security.c.

I've fixed my tree and Al has pulled it, but we're now waiting on Stephen
Rothwell to refresh linux/next.

David
