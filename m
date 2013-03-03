From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: [PATCH 08/14] MAINTAINERS: fix mach-omap2 clockdomain/powerdomain
Date: Sat,  2 Mar 2013 22:53:46 -0300
Message-ID: <1362275632-20242-9-git-send-email-cesarb@cesarb.net>
References: <1362275632-20242-1-git-send-email-cesarb@cesarb.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362275632-20242-1-git-send-email-cesarb@cesarb.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Cesar Eduardo Barros <cesarb@cesarb.net>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Russ Dill <Russ.Dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The code in these files was moved to cm*.[ch] and prm*.[ch] in the same
directory by commits 4981539 (ARM: OMAP2+: powerdomain/PRM: move the
low-level powerdomain functions into PRM) and 4bd5259 (ARM: OMAP2/3:
clockdomain/PRM/CM: move the low-level clockdomain functions into
PRM/CM).

I am not sure if this fix is correct, since there are other things in
these files. Please NAK this patch (and propose a better one) if it is
wrong.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Russ Dill <Russ.Dill@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92718d8..46c1288 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5651,10 +5651,8 @@ M:	Rajendra Nayak <rnayak@ti.com>
 M:	Paul Walmsley <paul@pwsan.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-F:	arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
-F:	arch/arm/mach-omap2/powerdomain44xx.c
-F:	arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
-F:	arch/arm/mach-omap2/clockdomain44xx.c
+F:	arch/arm/mach-omap2/cm*.[ch]
+F:	arch/arm/mach-omap2/prm*.[ch]
 
 OMAP AUDIO SUPPORT
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
-- 
1.7.11.7
