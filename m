From: Robert Schuster <theBohemian@gmx.net>
Subject: Nokia N800 - USB Host mode issues
Date: Fri, 29 Jun 2007 18:39:42 +0200
Message-ID: <468535CE.5070401@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
I am using the patches available from
http://www.muru.com/linux/n800-usb-host/

to enable the USB Host mode capability of the N800 device

.. and have some questions:

I connected an external powered USB Hub to it and tried a few devices.

a)
First of all: It works fine and I can for instance transmit big amount
of data through a USB ethernet device (using the pegasus.ko driver).
However it does not seem to like plugging devices of. Because after
doing so (in case of the ethernet device I did ifconfig eth0 down first)
the host will not accept the device anymore. It also seems to have
trouble communicating to the hub at all.

b)
The host did not accept an USB keyboard of mine which has two built-in
USB 1.1 ports (the real HUB is an USB 2.0 one).

Has any development happened on the USB Hostdriver for the N800 after
the release of the above mentioned patches?

Is there any interest to debug the problems a) and b) further? If so,
what info should I provide?

Regards
Robert Schuster
