From: Kevin Hilman <khilman@mvista.com>
Subject: Generic time for ARM and OMAP
Date: Thu, 28 Sep 2006 17:19:57 -0700
Message-ID: <451C66AD.7000705@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony,

A heads up for your next merge, now that the generic timekeeping
infrastructure is in mainline.

RMK has just merged the generic time support for ARM[1], and Daniel
Walker has converted the OMAP1 MPU and 32k timers over to use the new
'clocksource' method to support generic time[2].  The omap clocksource
is not yet applied, but it should be shortly.

Kevin


[1]http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3855/1
[2]http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3876/1
