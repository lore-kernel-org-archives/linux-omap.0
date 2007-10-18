From: "Amr Ayoub" <a.ayoub.omap@googlemail.com>
Subject: OSK5912 USB-Serial
Date: Thu, 18 Oct 2007 15:18:48 +0200
Message-ID: <47a77df0710180618l32e4c580j261545db65452cfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

I am trying to connect a device to the OSK5912 by using the USB-serial
cable. I have compiled the kernel with the following options enabled:
    Device Drivers --- <*> USB support --- <*> OHCI HCD Support
Device Drivers --- <*> USB support --- USB Serial Converter support --- <*>
USB Serial Converter support (NEW) --- <*> USB Prolific 2303 Single Port
Serial Driver  I am using  Linux-2.6.10_mvl401-omap5912_osk kernel and a
root file system mounted over nfs.

ttyUSB0 to ttyUSB15 are found under /dev

Trying to execute: stty -F /dev/ttyUSB0 9600 cs8 -istrip -parenb
produces: stty:
/dev/ttyUSB0: No such device
I also tried different port numbers but it wouldn't work.

Best Regards,
Amr Ayoub
