From: "Amit Gupta" <amitjobs05@gmail.com>
Subject: Validity of USB code on public folder
Date: Thu, 23 Aug 2007 00:30:16 +0530
Message-ID: <78d6ed630708221200s383d372dv1ff1f90bebe7b66a@mail.gmail.com>
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello all

I have been working on FSUSB port 0 host /gadget driver for sometime
on TI OMAP2430 SDP v4.0.

Well I havent been able to sucessfully test the available Linux USB
(host and gadget)driver. I am not sure if the code available in the
following public folder:-

http://linux.omap.com/pub/kernel/2430sdp/source/ (v3)

has been tested code for FSUSB port 0 - host and gadgets.

Since there is no point in studying the complete code and finding the
bugs in the same.

If its available , then atleast it should be minimal tested of its
basic functionality.

Bug1 :-

file name - Mux.h(......./arch-omap) is having the following mux configuration
	{"AD10_2430_GPIO78", 0, 1, 0x128, 3, PULL_ENABLED, PULL_UP},
although GPIO 78 offset address as per TRM is 0x12B(and not 0x128).


Kindly update me if its tested code.

Thanks & Regards

Amit
