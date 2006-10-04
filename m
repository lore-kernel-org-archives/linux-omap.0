From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in clock.c
Date: Wed, 04 Oct 2006 15:28:43 +0200
Message-ID: <4523B70B.6030100@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080700010309070005070907"
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

This is a multi-part message in MIME format.
--------------080700010309070005070907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warning

arch/arm/mach-omap1/clock.c: In function
'omap1_clk_enable_generic':
arch/arm/mach-omap1/clock.c:499: warning: 'return' with no
value, in function returning non-void

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------080700010309070005070907
Content-Type: text/plain;
 name="clock_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="clock_warning_patch.txt"

--- ./arch/arm/mach-omap1/clock.c_orig	2006-10-04 15:07:39.000000000 +0200
+++ ./arch/arm/mach-omap1/clock.c	2006-10-04 15:09:41.000000000 +0200
@@ -496,7 +496,7 @@ static int omap1_clk_enable_generic(stru
 		}
 	}
 
-	return;
+	return 0;
 }
 
 static void omap1_clk_disable_generic(struct clk *clk)


--------------080700010309070005070907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080700010309070005070907--
