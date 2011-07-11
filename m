From: Tony Lindgren <tony@atomide.com>
Subject: Remaining omap pull requests
Date: Mon, 11 Jul 2011 04:47:37 -0700
Message-ID: <20110711114736.GX5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

Below is a summary of the pending omap pull requests as there are still
few branches pending.

Can you please take a look and see what you can take of these for v3.1
merge window?

There's still quite a bit more code shrinkage, and the new code for 4460
and PRCM related changes are badly needed.

Here's what's still pending:

1. Branches to pull into omap/cleanup

   I will reply to this mail with a pull request for cleanup-part-3
   that contains Russell's timer cleanup patch and Paul's PRCM cleanup
   series.

2. Branches to pull into omap/fixes

   I will reply to this mail with a pull request for fixes-part-2 that
   contains Paul's PRCM fixes, and one McBSP fix also from Paul.

   This branch depends on cleanup-part-3 in #1 above for the PRCM fixes.

3. Branches to pull into omap/board

   This one needs one merge commit to clear the merge conflict that
   I posted on Sunday at:

   http://marc.info/?l=linux-omap&m=131032743717583&w=2

4. New code for minimal omap4460 support

   This I've posted here:

   http://marc.info/?l=linux-omap&m=131032754417673&w=2

   It has some a trivial merge conflict with the cleanup-part-3 in
   #1 above that you should be able to handle.

5. New code for ASoC and MFD changes

   Because of the TWL cleanup, it was agreed that the TWL related
   MFD/ASoC changes should be merged by us also. I will reply to
   this mail with a pull request for this email.

   Note that this could also be merged by the ASoC or MFD people
   if they pull in your omap/cleanup-part-2.

6. New code for PRCM changes

   This you might as well pull from Paul directly as posted here:

   http://marc.info/?l=linux-omap&m=131030152129307&w=2

   It depends on the PRCM fixes in #2 above. I've already pulled
   this into linux-omap master branch for testing.

The following order should be kept for these branches:

omap/cleanup
omap/fixes
omap/board

And after that these can be merged in whatever order:

new code for minimal 4460 support
new code for ASoC/MFD
new code for PRCM changes

Then there are two new boards remaining, but they both are waiting
on the machine_id patch.

Regards,

Tony
