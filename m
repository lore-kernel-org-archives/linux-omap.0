From: "arun c" <arun.edarath@gmail.com>
Subject: touch screen on 2430sdp not giving X and Y values
Date: Fri, 26 Oct 2007 18:02:47 +0530
Message-ID: <c656a4d20710260532wb60aa47r369f80c3c58c946a@mail.gmail.com>
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

Hi all,

I am working on 2430sdp. I am using the kernel linux-2.6.14-omap2-v4.

I wanted to use the touch screen on sdp. I built the kernel using the
default configuration came with the kernel source.

I downloaded the evtest.c from net to test the touch screen.

If i run it on 2430sdp i am getting the below result.

./a.out  /dev/input/event1
Input driver version is 1.0.0
Input device ID: bus 0x0 vendor 0x0 product 0x0 version 0x0
Input device name: "omap_tsc2046"
Supported events:
  Event type 0 (Sync)
  Event type 1 (Key)
    Event code 330 (Touch)
  Event type 3 (Absolute)
    Event code 0 (X)
      Value      0
      Min        0
      Max        0
    Event code 1 (Y)
      Value      0
      Min        0
      Max        0
    Event code 24 (Pressure)
      Value      0
      Min        0
      Max        0
Testing ... (interrupt to exit)
Event: time 65.154606, type 1 (Key), code 330 (Touch), value 1
Event: time 65.154699, -------------- Report Sync ------------
Event: time 66.350013, type 1 (Key), code 330 (Touch), value 0
Event: time 68.677161, type 1 (Key), code 330 (Touch), value 1
Event: time 68.677254, -------------- Report Sync ------------
Event: time 70.040013, type 1 (Key), code 330 (Touch), value 0
Event: time 72.004278, type 1 (Key), code 330 (Touch), value 1
Event: time 72.004371, -------------- Report Sync ------------
Event: time 73.570013, type 1 (Key), code 330 (Touch), value 0

I am not getting the X and Y cordinates no matter where ever
i touch on the screen..

am i missing anything????

Regards,
arun
