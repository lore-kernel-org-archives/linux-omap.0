From: "arun c" <arun.edarath@gmail.com>
Subject: touch screen on sdp
Date: Thu, 25 Oct 2007 19:40:43 +0530
Message-ID: <c656a4d20710250710n4096d3ces2a85528f1a2262b2@mail.gmail.com>
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
default configuration
came with the kernel source and i wrote an application to test the touch screen.

>From the driver source i understood that the driver has an evdev
interface and it registers /dev/input/event1 in my filesystem.

In my application i am reading /dev/input/event1 and printing the
valules. But i get same values where ever i press on the touch screen.
The output of my application is given below.


./touch   /dev/input/event1


Event: time 2846.820454, type 1, code 330, value 1
Event: time 2846.820546, type 0, code 0, value 0
Event: time 2846.830022, type 1, code 330, value 0
Event: time 2846.840192, type 1, code 330, value 1
Event: time 2846.840283, type 0, code 0, value 0
Event: time 2846.850018, type 1, code 330, value 0
Event: time 2846.955702, type 1, code 330, value 1


Why i am getting same values?? It must be different i think so.. please help me.

Regards,
arun
