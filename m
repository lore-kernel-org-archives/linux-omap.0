From: Tony Lindgren <tony@atomide.com>
Subject: Re: Omap update for post 2.6.20 posted
Date: Wed, 31 Jan 2007 11:30:04 -0800
Message-ID: <20070131193003.GO27224@atomide.com>
References: <20070126225129.GN29286@atomide.com>
	<45BB0080.1070409@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45BB0080.1070409@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070126 23:34]:
> Tony Lindgren wrote:
> >I've updated the patch series for upstream and posted it to RMK's
> >patch tracking system. The git tree of the patches is available at:
> >
> >http://www.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-upstream.git;a=summary
> >
> >And the upstream patches are in a branch like upstream-2007-01-26.
> >
> >There are currently 87 patches in the series, I'll keep updating
> >that series based on comments from RMK. The patches  in RMK's
> >patch system are at:
> >
> >http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4113/1
> >http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4114/1
> >http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4115/1
> >http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4116/1
> >
> >Assuming we get these applied, we'll be switching over to using
> >the mainline tree for core omap stuff :) Only dsp code and sti
> >console will not be included.
> 
> Great!
> 
> I'll keep my fingers crossed.

I've rebased the tree against 2.6.20-rc7, the new branch name is
upstream-2007-01-31. Also added Dirk's IRQF_ conversion patch
and fixed some whitespace issues with the earlier patches.

The individual patches for quilt are available at:

http://www.kernel.org/pub/linux/kernel/people/tmlind/patches/

(The new series will be there as soon as it gets mirrorred)

Regards,

Tony
