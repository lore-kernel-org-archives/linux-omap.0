From: Bryan Wu <bryan.wu@analog.com>
Subject: Some musb Blackfin porting issues
Date: Thu, 06 Sep 2007 14:52:25 +0800
Message-ID: <1189061545.8833.11.camel@roc-desktop>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear David and Tony:

I almost imported the musb stack to our Blackfin tree. But there are
some code highly coupled with ARM Linux architecture. Please give me
some idea about following issues:

1. Clock framework is not available in Blackfin Linux arch currently. Is
it possible to skip it?

2. Registers layout in musb-regs.h is different with BF54x processor. I
plan to write a musb-bf54x.h to replace the whole definition in
musb-regs.h. Is that possible or do it conflict with current musb
design?
in musb-regs.h:
---
#ifdef CONFIG_BF54x
#include "musb-bf54x.h"
#else
..... /* original code from musb-regs.h */
#endif
--

Thanks a lot
- Bryan Wu
