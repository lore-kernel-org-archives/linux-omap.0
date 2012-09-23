From: Paul Walmsley <paul@pwsan.com>
Subject: Re: rcu self-detected stall messages on OMAP3, 4 boards
Date: Sun, 23 Sep 2012 02:01:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209230159100.28806@utopia.booyaka.com>
References: <20120920232114.GO2449@linux.vnet.ibm.com> <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com> <20120921185827.GC2454@linux.vnet.ibm.com> <alpine.DEB.2.00.1209211900520.8839@utopia.booyaka.com> <20120921195717.GD2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209221836070.10663@utopia.booyaka.com> <20120922201043.GE2934@linux.vnet.ibm.com> <20120922215923.GA13161@linux.vnet.ibm.com> <alpine.DEB.2.00.1209222223080.22590@utopia.booyaka.com> <alpine.DEB.2.00.1209230136320.28806@utopia.booyaka.com>
 <20120923015645.GJ2934@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120923015645.GJ2934@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Bruce, Becky" <bbruce@ti.com>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "<snijsure@grid-net.com>" <snijsure@grid-net.com>, fweisbec@gmail.com
List-Id: linux-omap@vger.kernel.org

On Sat, 22 Sep 2012, Paul E. McKenney wrote:

> Very cool, thank you for your testing efforts!!!

You're welcome.

> May I apply your Tested-by to this patch?

Please do:

Tested-by: Paul Walmsley <paul@pwsan.com>  # OMAP4430

Am testing on OMAP3730 (single-core) now.


- Paul
