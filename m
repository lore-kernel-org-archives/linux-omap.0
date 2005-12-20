From: <venkata.sunilkumar@wipro.com>
Subject: usb 1-2: device descriptor read/64, error -110
Date: Tue, 20 Dec 2005 10:24:00 +0530
Message-ID: <A532B29682CD634080ABC65F9A1BFB42022697CD@BLR-EC-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

Hi
    Im working on OMAP 1710 -usb drivers for making the USB host
controller up,
    I have configured the kernel with OHCI_HCD Support.
    while uncompresssing the kernel got some error message as
     "usb 1-2: device descriptor read/64, error -110"=20
    the function usb_start_wait_urb() is returing -ETIMEDOUT .Any one in
the list got this
    type of error before? and why does the function usb_start_wait_urb
returing -ETIMEDOUT=20
=20
Thanks
Sunil
