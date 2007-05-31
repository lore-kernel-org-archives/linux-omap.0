From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 1/12] Add VFP support for ARM V7 - OMAP 3430 support
Date: Thu, 31 May 2007 14:33:54 -0700
Message-ID: <465F3F42.1020805@mvista.com>
References: <9C23CDD79DA20A479D4615857B2E2C470106320C@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C470106320C@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Syed Mohammed, Khasim wrote:
> Add VFP support for ARM V7, derived from ARM's Cortex patch
> 

Sorry to not speak up sooner, but I think we need to rebase this whole patchset on top of Catalin's ARMv7 patches which he has in his tree[1]

I just did a quick test and all his patches apply cleanly to the current OMAP git tree.  Here's the git magic for how I do it: (you might need a recent git for this, I use 1.5.2)

$ git remote add arm git://linux-arm.org/linux-2.6.git

Then fetch his changes into your repo

$ git fetch arm

Then cherry-pick the commits from his tree into your tree.  To me it seems like the following range is useful his ARMv7 + NEON + VFP3 + Thumb-2 userland support:

$ git-rev-list --reverse arm/origin..654441661e3655df22fb7b85a7fc64201c09f4d0

Then, cherry-pick them into your OMAP tree (this cmd should be all on one line)

$ for commit in `git-rev-list --reverse arm/origin..654441661e3655df22fb7b85a7fc64201c09f4d0`; do git-cherry-pick -x ${commit}; done

Kevin


[1] http://www.linux-arm.org/git
