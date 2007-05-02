From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] omap2: trivial cleanup patches
Date: Wed, 02 May 2007 12:33:20 -0600
Message-ID: <20070502183320.656693735@pwsan.com>
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

Hello,

Here are three trivial cleanup patches against linux-omap git head.
Patches 1 and 2 fix some formatting issues in mach-omap2/clock.h,
patch 3 hoists and renames the OMAP242X_CONTROL_STATUS defines in
arch-omap/omap24xx.h to indicate that the define is shared across
architectures. 


- Paul

-- 
