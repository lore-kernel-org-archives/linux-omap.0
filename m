From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM compile failure in Re: linux-next: Tree for Apr 4
Date: Wed, 4 Apr 2018 10:58:52 -0700
Message-ID: <20180404175852.GI5700@atomide.com>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180404074856.GA9342@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180404 07:50]:
> Hi!
> 
> > Please do not add any v4.18 destined stuff to your linux-next included
> > trees until after v4.17-rc1 has been released.
> > 
> > Changes since 20180403:
> > 
> > The vfs tree still had its build failure for which I reverted a commit.
> > 
> > Non-merge commits (relative to Linus' tree): 8505
> >  8493 files changed, 392779 insertions(+), 275941 deletions(-)
> > 
> > ----------------------------------------------------------------------------
> 
> When trying to build kernel for N900, I get:
> 
>   CC      lib/timerqueue.o
>     CC      lib/vsprintf.o
>     lib/string.c: In function 'strstr':
>     lib/string.c:478:8: error: inlining failed in call to
>     always_inline 'strlen': function not inlinable
>     lib/string.c:903:5: error: called from here
>     lib/string.c:478:8: error: inlining failed in call to
>     always_inline 'strlen': function not inlinable
>     lib/string.c:906:5: error: called from here
>     lib/string.c:855:15: error: inlining failed in call to
>     always_inline 'memcmp': function not inlinable
>     ...
> pavel@duo:/data/l/linux-next-n900$ git branch -l
> * (detached from next-20180403)
> 
> I'm using
> 
> eval ` eldk-switch.sh -r 5.4 armv7a`
> 
> for cross-compilation.

Hmm I'm not seeing build issues with next-20180404, did this somehow
already get sorted out?

Regards,

Tony
