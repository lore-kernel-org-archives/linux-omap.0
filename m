From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: IS_ERR_OR_NULL - please STOP telling people to use this on a
	whim
Date: Wed, 17 Oct 2012 22:33:42 +0100
Message-ID: <20121017213342.GA28061@n2100.arm.linux.org.uk>
References: <20121017194157.GM21164@n2100.arm.linux.org.uk> <20121017202848.GF22812@fatphil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121017202848.GF22812@fatphil.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Phil Carmody <pc+lkml@asdf.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 17, 2012 at 11:28:48PM +0300, Phil Carmody wrote:
> So, what to do? It can and has been used sensibly, so I don't think removing
> it is the best option.

Well, the first thing that needs to be done is a full review of every user
and fixes applied.

The second thing is that we need eyes on code _and_ review comments, and
educate those who are telling people to use IS_ERR_OR_NULL() whenever they
see an IS_ERR() to think about the code a little more - that's kind of the
purpose of my email.

Unfortunately, it's going to take time to achieve a change, and if I end
up being the only one who's spotting these errors, I'm going to get
incredibly pissed off at doing so (because it will feel like I'm being
ignored when there's a constant stream of it.)

Another thing would be to work out whether we can get checkpatch to
detect usage of IS_ERR_OR_NULL(p) followed by PTR_ERR(p) without any
explicit NULL checks against p in the same block.  That's probably
going to be interesting to code up in perl.
