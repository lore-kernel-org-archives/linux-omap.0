From: "Wael Adel" <showairovic@gmail.com>
Subject: error when compiling testusb.c
Date: Wed, 14 Mar 2007 05:18:01 -0400
Message-ID: <bd205c5f0703140218r6d62d678o35e1ad03b26efe5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

hi all,
i want to test the hcd of my computer so i download
1)testusb.c
2)test.sh

i m using kernel version 2.6.18
when i tried to compile testusb.c i got the following errors:

In file included from testusb.c:34:
/usr/include/linux/usbdevice_fs.h:49: error: expected ':', ',', ';',
'}' or '__attribute__' before '*' token
/usr/include/linux/usbdevice_fs.h:56: error: expected ':', ',', ';',
'}' or '__attribute__' before '*' token
/usr/include/linux/usbdevice_fs.h:66: error: expected ':', ',', ';',
'}' or '__attribute__' before '*' token
/usr/include/linux/usbdevice_fs.h:100: error: expected ':', ',', ';',
'}' or '__attribute__' before '*' token
/usr/include/linux/usbdevice_fs.h:116: error: expected ':', ',', ';',
'}' or '__attribute__' before '*' token

thanks in advance
