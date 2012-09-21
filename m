From: Paul Walmsley <paul@pwsan.com>
Subject: Re: rcu self-detected stall messages on OMAP3, 4 boards
Date: Fri, 21 Sep 2012 17:51:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209211748320.8839@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209122237080.7275@utopia.booyaka.com> <20120913011208.GT4257@linux.vnet.ibm.com> <alpine.DEB.2.00.1209131839000.23318@utopia.booyaka.com> <20120920000351.GI2455@linux.vnet.ibm.com> <alpine.DEB.2.00.1209200753450.3801@utopia.booyaka.com>
 <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com> <20120920220130.GN2449@linux.vnet.ibm.com> <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com> <alpine.DEB.2.00.1209211740170.8839@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1209211740170.8839@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Bruce, Becky" <bbruce@ti.com>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "<snijsure@grid-net.com>" <snijsure@grid-net.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 21 Sep 2012, Paul Walmsley wrote:

> The config used was 'omap2plus_defconfig', and enabled CONFIG_CPU_IDLE 
> by hand. 

One other thing I forgot to mention - CONFIG_RCU_CPU_STALL_INFO was 
enabled by hand also.  Below is the diff between omap2plus_defconfig and 
the config that was used here.


- Paul

--- .config	2012-09-21 11:50:19.565972113 -0600
+++ .testconfig	2012-09-21 11:50:12.233946950 -0600
@@ -536,7 +536,9 @@
 # CPU Frequency scaling
 #
 # CONFIG_CPU_FREQ is not set
-# CONFIG_CPU_IDLE is not set
+CONFIG_CPU_IDLE=y
+CONFIG_CPU_IDLE_GOV_LADDER=y
+CONFIG_CPU_IDLE_GOV_MENU=y
 CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED=y
 
 #
@@ -2535,7 +2537,7 @@
 # CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
-# CONFIG_RCU_CPU_STALL_INFO is not set
+CONFIG_RCU_CPU_STALL_INFO=y
 # CONFIG_RCU_TRACE is not set
 # CONFIG_KPROBES_SANITY_TEST is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
