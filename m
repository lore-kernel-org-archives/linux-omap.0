From: Olav Kongas <ok@artecdesign.ee>
Subject: removal of spinlock from dma.c?
Date: Mon, 23 Jan 2006 14:00:19 +0200 (EET)
Message-ID: <Pine.LNX.4.63.0601231243150.15249@pcy.artec.ee>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hi,

In /arch/arm/plat-omap/dma.c, the structure lcd_dma contains 
a spinlock. It seems that the lock is used to only guard for 
the .reserved field in the same structure. Would the same be 
achieved by making .reserved atomic and removing spinlock?

Olav
