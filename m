From: David Brownell <david-b@pacbell.net>
Subject: Re: JFFS2 issues on OSK?
Date: Sun, 6 Apr 2008 17:36:13 -0700
Message-ID: <200804061736.13333.david-b@pacbell.net>
References: <200803180026.25802.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:27671 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755523AbYDGAgT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 20:36:19 -0400
In-Reply-To: <200803180026.25802.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Tuesday 18 March 2008, David Brownell wrote:
> This is strange.  When I try to mount /dev/mtdblock3 as the
> root FS I get a variety of errors (minimally "point returned
> len too short: 0") ... which do *not* appear later when I just
> issue a "mount -t jffs2 /dev/mtdblock3 /mnt"!!

Update:  the latest kernel.org GIT (nyet OMAP git) has a patch
which seems to resolve this issue.  It's a NOR flash corruption
issue specific to CFI command set 1 (Intel), dating since early
October:  c4a9f88daf6c382fedde4cdddef0b30f1d0a20db caused this.

This afflicted OSK, since its Micron flash is compatible with
Intel's Strataflash.  The failure mode variability was caused by
different read and write patterns.

If you have NOR flash issues, you may *NEED* this fix.

- Dave


commit fb6d080c6f75dfd7e23d5a3575334785aa8738eb
Author: Alexey Korolev <akorolev@infradead.org>
Date:   Fri Apr 4 14:30:01 2008 -0700

    mtd: fix broken state in CFI driver caused by FL_SHUTDOWN
    
    THe CFI driver in 2.6.24 kernel is broken.  Not so intensive read/write
    operations cause incomplete writes which lead to kernel panics in JFFS2.
    
    We investigated the issue - it is caused by bug in FL_SHUTDOWN parsing code.
    Sometimes chip returns -EIO as if it is in FL_SHUTDOWN state when it should
    wait in FL_PONT (error in order of conditions).
    
    The following patch fixes the bug in state parsing code of CFI.  Also I've
    added comments to notify developers if they want to add new case in future.
    
    Signed-off-by: Alexey Korolev <akorolev@infradead.org>
    Reviewed-by: Joern Engel <joern@logfs.org>
    Cc: David Woodhouse <dwmw2@infradead.org>
    Cc: <stable@kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 47794d2..0080452 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -718,7 +718,7 @@ static int chip_ready (struct map_info *map, struct flchip *chip, unsigned long
 			/* Someone else might have been playing with it. */
 			return -EAGAIN;
 		}
-
+		/* Fall through */
 	case FL_READY:
 	case FL_CFI_QUERY:
 	case FL_JEDEC_QUERY:
@@ -778,14 +778,14 @@ static int chip_ready (struct map_info *map, struct flchip *chip, unsigned long
 		chip->state = FL_READY;
 		return 0;
 
+	case FL_SHUTDOWN:
+		/* The machine is rebooting now,so no one can get chip anymore */
+		return -EIO;
 	case FL_POINT:
 		/* Only if there's no operation suspended... */
 		if (mode == FL_READY && chip->oldstate == FL_READY)
 			return 0;
-
-	case FL_SHUTDOWN:
-		/* The machine is rebooting now,so no one can get chip anymore */
-		return -EIO;
+		/* Fall through */
 	default:
 	sleep:
 		set_current_state(TASK_UNINTERRUPTIBLE);

