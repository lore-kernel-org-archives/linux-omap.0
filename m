From: Kevin Hilman <khilman@mvista.com>
Subject: simple DMA test module
Date: Tue, 27 Mar 2007 17:08:35 -0700
Message-ID: <4609B203.5070907@mvista.com>
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

A while back I posted a simple kernel module for testing various ways of
linking and looping memory-to-memory DMA transfers[1].  I've updated
that test to work with the current git tree, and it can be found here:
http://source.mvista.com/~khilman/omap/dmatest.tgz.

I validated on OMAP1 (OSK) and OMAP2 (2430SDP)

Kevin


[1]
http://linux.omap.com/pipermail/linux-omap-open-source/2004-June/000956.html
