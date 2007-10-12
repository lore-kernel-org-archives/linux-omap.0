From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] Make dyntick work again
Date: Fri, 12 Oct 2007 15:16:12 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290231FFA1@dlee13.ent.ti.com>
References: <20071011203240.GL503@atomide.com><002c01c80c74$9f0f5160$e1ac580a@swcenter.sec.samsung.co.kr>
	<20071012200612.GE7979@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <20071012200612.GE7979@atomide.com>
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

Hi,

> Time to try powertop on omap!

Here is powertop running on 3430 using dynamic tick :)  It would be nice =
to format the C state information such that it reports residency.  =
Sometime in the future.  It is directly useable for seeing timers.  Not =
so many timers running on a full up NFS mounted system.  It used to run =
fine on OMAP2 from GIT once clocksource came.

--------------------
< Detailed C-state information is only available on Mobile CPUs =
(laptops) >

Wakeups-from-idle per second : 13.1     interval: 10.0s


Top causes for wakeups:
  38.9% (  4.2)       <interrupt> : 32KHz timer
  29.6% (  3.2)       <interrupt> : eth0
   9.3% (  1.0)     <kernel core> : __netdev_watchdog_up (dev_watchdog)
   4.6% (  0.5)     <kernel core> : queue_delayed_work_on =
(delayed_work_timer_fn
   2.8% (  0.3)     <kernel core> : irlmp_start_discovery_timer =
(irlmp_discovery
_timer_expired)

root@128.247.75.244:/tst# uname -a
Linux 128.247.75.244 2.6.22.1-omap1 #3 Fri Oct 12 14:53:45 CDT 2007 =
armv7l GNU/L
inux
root@128.247.75.244:/tst# cat /proc/cpuinfo | grep OMAP
Hardware        : OMAP3430 sdp3430 board
root@128.247.75.244:/tst#
--------------------

Regards,
Richard W.
