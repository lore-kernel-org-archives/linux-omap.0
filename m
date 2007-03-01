From: Tony Lindgren <tony@atomide.com>
Subject: Git tree updated
Date: Thu, 1 Mar 2007 06:33:32 -0800
Message-ID: <20070301143330.GF26097@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

As discussed earlier, I've made some changes to our git tree to make it
easier to send patches upstream. I've added some branches internally to
the git tree, and the master branch is based on these new branches.

>From usage point of view, this change is transparent. Git pull should
work as earlier, there are just new branches there. The master branch
is still our development branch, and the other branches are just queues
for upstream.

Now we have following branches:

linus
     \
      omap-fixes
                \
                 omap-upstream
                              \
                               omap-drivers
                                           \
                                            master

The branches have following purpose:

linus		Linus' mainline tree
omap-fixes	Queue of omap fixes for -rcN series
omap-upstream	Queue of omap core patches for next merge window
omap-drivers	Queue of omap drivers for next merge window
master		Linux omap tree

I'll be rebasing the omap-fixes, omap-upstream, and omap-drivers branches
against the mainline tree, and then merging the changes to the master
branch.

Sorry if this change took a bit longer than expected, I got interrupted
with few other things and was not happy with the branch layout until
today :)

In case anybody is wondering, I rebuilt the new master branch by
applying the patch queues on top of 2.6.20 to various branches,
and then merged in our old tree so the resulting trees were identical.

Today I also updated the new tree few times to make sure things work
out as planned, so the tree is now in sync with the mainline tree.

Regards,

Tony
