From: "Carlos, John J DA CIV USA ATC" <john.carlos@atc.army.mil>
Subject: RE: FIFO_FULL on camera driver
Date: Tue, 11 Apr 2006 11:02:36 -0400
Message-ID: <22CECCE071A8DC4CAB2412DC44CBEDF107A5A64C@apgrb1atc-0058e.atc.army.mil>
Mime-Version: 1.0
Content-Type: text/plain
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
To: "'Zhang, Jian'" <jzhang@ti.com>, "Carlos, John J DA CIV USA ATC" <john.carlos@atc.army.mil>, Linux-Omap-Open-Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Jian,

  I don't do any processing till after I read a full buffer.  Not sure why I
am over running the buffer do you know a spec on the speed the camera
interface can handle.  As I mentioned the period on the frame is about 12
msec faster then the cmos sensor I have that works.

Thanks again,
John 

-----Original Message-----
From: Zhang, Jian [mailto:jzhang@ti.com] 
Sent: Tuesday, April 11, 2006 10:45 AM
To: Carlos, John J DA CIV USA ATC; Linux-Omap-Open-Source
Subject: RE: FIFO_FULL on camera driver

The driver may not be the cause for the FIFO overflow. It is most likely
that your post-processing code is not running fast enough.

Regards,
Jian  

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Carlos,
John J DA CIV USA ATC
Sent: Tuesday, April 11, 2006 9:38 AM
To: Linux-Omap-Open-Source
Subject: FIFO_FULL on camera driver

Hello All,

	I am using 2.6.14-rc1-omap1 on OSK5912.  I am working with a video
decoder with a 8 bit camera interface.  When I run a test application to
collect data I get FIFO_FULL error messages.  The frame pulse is about
33msec period.  This is a bit faster the a cmos sensor I use that works fine
(45 msec period).  What clocking can be adjusted to stop the fifo overrun?

Thanks,

John
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
