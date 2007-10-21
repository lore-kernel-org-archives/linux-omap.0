From: Dirk Behme <dirk.behme@googlemail.com>
Subject: OMAP FB drivers muck up the FB menu?
Date: Sun, 21 Oct 2007 08:02:00 +0200
Message-ID: <471AEB58.5010608@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: linux-omap-open-source@linux.omap.com, randy.dunlap@oracle.com
List-Id: linux-omap@vger.kernel.org


In

http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.23-git15.log

I just found this:

-- cut --
commit 0058f479e52d0c0718c843cb34223bc1bfce36e1
Author: Randy Dunlap <randy.dunlap@oracle.com>
Date:   Tue Oct 16 01:29:35 2007 -0700

     video gfx: fix menu ordering

     Move video graphics driver configs to fix menus:

     ...
     The OMAP FB drivers still muck up the FB menu a bit, so I put
       OMAP drivers at the end of the FB menu.

     ...
-- cut --

Anybody with an idea what is meant there?

In same changelog there is from Randy as well:

-- cut --
commit e82ce352335b643755a7fa4130b11d6d7adcf10c
Author: Randy Dunlap <randy.dunlap@oracle.com>
Date:   Tue Oct 16 23:29:44 2007 -0700

     maintainers: linux-omap list is subscribers only

     You are not allowed to post to this mailing list, and your 
message has been
     automatically rejected.  If you think that your messages are 
being rejected
     in error, contact the mailing list owner at
     linux-omap-open-source-owner@linux.omap.com.

     Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
     Cc: Tony Lindgren <tony@atomide.com>
     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
-- cut --

Randy: Did you like to contact linux-omap list regarding OMAP FB issue 
and got a reject?

Regards

Dirk
