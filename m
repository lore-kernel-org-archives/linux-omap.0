From: Paul Walmsley <paul@pwsan.com>
Subject: Re: rcu self-detected stall messages on OMAP3, 4 boards
Date: Fri, 21 Sep 2012 18:59:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209211855500.8839@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209122237080.7275@utopia.booyaka.com> <20120913011208.GT4257@linux.vnet.ibm.com> <alpine.DEB.2.00.1209131839000.23318@utopia.booyaka.com> <20120920000351.GI2455@linux.vnet.ibm.com> <alpine.DEB.2.00.1209200753450.3801@utopia.booyaka.com>
 <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com> <20120920220130.GN2449@linux.vnet.ibm.com> <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com> <20120920232114.GO2449@linux.vnet.ibm.com> <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Bruce, Becky" <bbruce@ti.com>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "<snijsure@grid-net.com>" <snijsure@grid-net.com>, fweisbec@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi

Just did a test with CONFIG_NO_HZ=n, and no rcu_sched stall messages 
appeared for 60 minutes.

Following is the diff from omap2plus_defconfig.

- Paul

--- .config	2012-09-21 12:51:19.114938954 -0600
+++ .testconfig	2012-09-21 12:51:15.686926318 -0600
@@ -69,7 +69,7 @@
 # Timers subsystem
 #
 CONFIG_TICK_ONESHOT=y
-CONFIG_NO_HZ=y
+# CONFIG_NO_HZ is not set
 CONFIG_HIGH_RES_TIMERS=y
 
 #
@@ -80,7 +80,6 @@
 CONFIG_RCU_FANOUT=32
 CONFIG_RCU_FANOUT_LEAF=16
 # CONFIG_RCU_FANOUT_EXACT is not set
-# CONFIG_RCU_FAST_NO_HZ is not set
 # CONFIG_TREE_RCU_TRACE is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
@@ -2535,7 +2534,7 @@
 # CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
-# CONFIG_RCU_CPU_STALL_INFO is not set
+CONFIG_RCU_CPU_STALL_INFO=y
 # CONFIG_RCU_TRACE is not set
 # CONFIG_KPROBES_SANITY_TEST is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
