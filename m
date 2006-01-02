From: janiszo@poczta.onet.pl
Subject: USB problem in 2.6.14.5
Date: Mon, 02 Jan 2006 11:40:36 +0100
Message-ID: <20060102104036Z4334330-19345+1244@kps4.test.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
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
Are there any changes in kernel 2.6.14 against 2.6.11 with USB support? I compiled new kernel with the same options as in the old one and system cannot see USB devices now. There is no /proc/bus/usb folder at all, while during startup mesaages about usbcore/ohci/mass storage registering appear.
I'm, using kernel 2.6.14.5 with patch-2.6.14-omap2.

Jack 
