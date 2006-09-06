From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: MMC H2 problem
Date: Wed, 06 Sep 2006 16:23:08 -0400
Message-ID: <44FF2E2C.4010206@indt.org.br>
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
To: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi all,

Is the mmc omap driver for h2 broken on actual git tree? I'm trying to use, but when I
load the omap.ko module I have this warning:

root@arm:~# modprobe omap
No IRQF_TRIGGER set_type function for IRQ 353 (MPUIO)

and when I tried to use the MMC card (inserting/removing from mmc slot) the system hangs
and I have a soft lockup error (with a dump message):

root@arm:~# BUG: soft lockup detected on CPU#0!


Anderson Briglia
