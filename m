From: karthik <skarthikeyan_17@yahoo.com>
Subject: usb camera in osk5912 ; bus power : urgent
Date: Sat, 14 Apr 2007 13:19:35 -0700 (PDT)
Message-ID: <201180.10923.qm@web51411.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
I tried connecting creative videoblaster webcam go, and another logitech webcam to osk5912. i get  the message

usb 1-1: new full speed USB device using ohci and address 2
usb 1-1: rejected 1 configuration due to insufficient available bus power
usb 1-1: no configuration chosen from 1 choice

How do i increase bus power? can i connect usb hubs? do i need Y cables that have there own alternative power?  
i have a Y cable that comes with external portable hard disks i tried using that with one end connected to my PC and the other two ends to cam and kit. The light in the camera glows but i get teh same error message from linux (without Y cable, the light does not glow). 
It is the same with two other cameras. 
i checked pin 1 and 4.. it gives 5 volts. 

------
# cat /sys/devices/platform/ohci/usb1/1-1/idProduct
08b2
# cat /sys/devices/platform/ohci/usb1/1-1/idVendor
046d
#
------
Please treat this as urgent.

regs karthik

       
---------------------------------
Ahhh...imagining that irresistible "new car" smell?
 Check outnew cars at Yahoo! Autos.
