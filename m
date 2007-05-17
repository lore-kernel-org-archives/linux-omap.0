From: Paul Walmsley <paul@pwsan.com>
Subject: Request for review: New PRCM framework (and prerequisites)
Date: Wed, 16 May 2007 19:27:36 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0705161926340.355@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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


Hi everyone,

The following patches implement the long-awaited PRCM register cleanup
for mach-omap2/.  The patches are separated into four series:

1. omap24xx.h cleanup (5 patches)

2. SDRC cleanup (3 patches)

3. new PRCM framework for OMAP24XX, and prcm-regs.h removal (18 patches)

4. add OMAP3430 PRCM support (7 patches)

Descriptions of each individual series are posted before the patches.

Reviewing the converted code, I'm pleased with the improvement in
readability, and hope you are also.

Any comments you might have are welcome.


- Paul
