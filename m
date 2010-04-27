From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] omap fixes for v2.6.34-rc5
Date: Tue, 27 Apr 2010 08:31:59 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1004270831430.3739@i5.linux-foundation.org>
References: <20100426190005.GJ7225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100426190005.GJ7225@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


On Mon, 26 Apr 2010, Tony Lindgren wrote:
> 
> Please pull omap fixes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

I pulled it this time, but I'm starting to get really irritated with you.

These look like real fixes, but quite frankly, by -rc5, that IS NOT 
ENOUGH. 

They need to be _regressions_, not just cleanups and fixes for things that 
have never worked. And this is starting to be a pattern with the omap 
tree: you're not honoring the merge window properly.

Just "it's a bug-fix" or "it's deleting unused code" is not enough. The 
point of the late -rc series is to fix problems from the merge window, not 
add new changes. I realize that you think that all the new changes are 
obviously good, but the fact is, bugs happen even in "obvious bug-fixes". 

And that's why we have the rule about late-rc pulls being about 
_regressions_ and/or major oopses/security issues. Not just random 
development that are meant to improve things.

		Linus
