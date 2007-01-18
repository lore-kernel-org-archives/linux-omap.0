From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: SPI related oops
Date: Thu, 18 Jan 2007 20:44:58 +0100
Message-ID: <85mz4gdsqt.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Since some time ago I was seeing a reboot as long as my n770 was
booting recent kernels from the omap git. Now, I found out that the
crash is due to a oops as soon as udev plays with the uevent file of the
spi master. 
After some debugging, I found that the following commit is the culprit : 
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=3bd0f6943520e459659d10f3282285e43d3990f1

Reverting it allows my kernel to boot but I think it's not a real
fix. Has someone seen a similar issue and has a fix for it ?

[ Also, I'm wondering why the spi_busnum_to_master() function exists
because grepping the current omap git tree gives 0 user... ]

Regards,
Arnaud
