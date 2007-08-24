From: "Amit Gupta" <amit_jobs05@inbox.com>
Subject: USB Function Driver code for OMAP 2430 SDP
Date: Sat, 25 Aug 2007 02:28:38 +0530
Message-ID: <78d6ed630708241358y301118b6hd7a5286b4277298@mail.gmail.com>
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

This is in continuation of the previous mail as below

Are there any patches for the FSUSB function controller on OMAP2430
SDPv4.0 since the code available in the public folder does not seem to
work.

---------- Forwarded message ----------
From: Amit Gupta <amitjobs05@gmail.com>
Date: Aug 23, 2007 12:30 AM
Subject: Validity of USB code on public folder
To: Linux OMAP <linux-omap-open-source@linux.omap.com>


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
