From: Tony Lindgren <tony@atomide.com>
Subject: Re: Bunch of CRC errors in next with arm: move exports to definitions
Date: Fri, 26 Aug 2016 11:46:06 -0700
Message-ID: <20160826184605.4a4u4bxoknmdlgai@atomide.com>
References: <20160822162512.mptzbiaozx2fz42l@atomide.com>
 <20160826181910.ujtk325yqsmvfpbg@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160826181910.ujtk325yqsmvfpbg@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160826 11:20]:
> * Tony Lindgren <tony@atomide.com> [160822 09:28]:
> > Hi Al,
> > 
> > Looks like starting with next-20160818 I'm now getting close to
> > 800 lines of WARNINGs on ARM with omap2plus_defconfig while doing
> > make modules:
> ...
> > Reverting commit 4dd1837d7589 ("arm: move exports to definitions")
> > fixes it.
> 
> And not happening with multi_v7_defconfig for example. Adding Russell
> to Cc, maybe he already has a fix for this one?

And this issue does not seem to happen with omap2plus_defconfig when
compiled with:

gcc version 4.8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29)

But does happen when compiled with:

gcc version 6.1.1 20160705 (Debian 6.1.1-9)

Regards,

Tony
