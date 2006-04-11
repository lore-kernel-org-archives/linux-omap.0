From: "Carlos, John J DA CIV USA ATC" <john.carlos@atc.army.mil>
Subject: FIFO_FULL on camera driver
Date: Tue, 11 Apr 2006 10:37:42 -0400
Message-ID: <22CECCE071A8DC4CAB2412DC44CBEDF107A5A64B@apgrb1atc-0058e.atc.army.mil>
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
To: Linux-Omap-Open-Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello All,

	I am using 2.6.14-rc1-omap1 on OSK5912.  I am working with a video
decoder with a 8 bit camera interface.  When I run a test application to
collect data I get FIFO_FULL error messages.  The frame pulse is about
33msec period.  This is a bit faster the a cmos sensor I use that works fine
(45 msec period).  What clocking can be adjusted to stop the fifo overrun?

Thanks,

John 
