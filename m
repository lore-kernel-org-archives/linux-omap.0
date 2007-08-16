From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/36] musb_hdrc: Yet more musb clean-up
Date: Thu, 16 Aug 2007 02:40:23 -0700
Message-ID: <11872572591844-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Here's still some more musb driver clean-up, including
the license update to make it generic instead of Mentor
specific.

Again, I haven't touched cppi_dma or musbhsdma code much
except for common variable names. These files still suffer
from badCamelCasingSymptoms.

Tested on tusb.

Regards,

Tony
