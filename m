From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH 0/1] ARM: OMAP: Fix musb_core parameter passing to cppi start
Date: Mon, 08 Oct 2007 20:34:34 +0200
Message-ID: <470A783A.1080007@googlemail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


People on DaVinci list report crash

Internal error: Oops: 805 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.23-rc4-davinci1 #2)
PC is at cppi_controller_start+0x18/0x140
LR is at musb_probe+0x1f4/0x824

Because msub code looks mainly identical fix it in OMAP tree. DaVinci 
updates from OMAP, so with next git update DaVinci will get this fix 
as well. Tested on DaVinci

http://linux.omap.com/pipermail/davinci-linux-open-source/2007-October/004223.html

Initial proposal for fix by David Brownell. Thanks!

Best regards

Dirk
