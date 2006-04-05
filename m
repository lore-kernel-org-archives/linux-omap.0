From: Matt Callow <mc-lists@tesco.net>
Subject: FIQ Handler
Date: Wed, 05 Apr 2006 22:22:08 +0100
Message-ID: <44343500.1030306@tesco.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I've been trying to install a FIQ handler for an omap 5910 board
(actually the amstrad E3) but I seem to get a data abort exception as
soon as I read the SIR_FIQ_CODE register.
I note in the omap source (arch/arm/mach-omap1/irq.c) it says  read the
mailing list threads on FIQ handlers if you are planning to add a FIQ
handler. So, I've looked through the archives but can only find a
reference to http://lkml.org/lkml/2005/6/22/111

Is there more information that I'm missing. If so, could someone point
me in the right direction please.

Matt
