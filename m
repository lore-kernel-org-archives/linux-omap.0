From: David Howells <dhowells@redhat.com>
Subject: Re: Regression in next with filesystem context concept
Date: Fri, 07 Sep 2018 09:47:26 +0100
Message-ID: <9053.1536310046@warthog.procyon.org.uk>
References: <20180906164358.GI5659@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906164358.GI5659@atomide.com>
Content-ID: <9052.1536310046.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote:

> Looks like next-20180906 now has a regression where mounting
> root won't work with commit fd0002870b45 ("vfs: Implement a
> filesystem superblock creation/configuration context").

Am I right in thinking you're not using any of the LSMs?

David
