From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [RFD] [PATCH] omap24xx vout and dispc library
Date: Thu, 15 Dec 2005 00:41:12 -0800 (PST)
Message-ID: <20051215084112.8426.qmail@web32907.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-761951586-1134636072=:8193"
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

--0-761951586-1134636072=:8193
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Imre/Tony,

I have attached the patch (compressed .gz) which includes (done by Jian
and the team...)

o display functions library [display.[ch]].
  - Location: arch/arm/mach-omap2/display.c
  - common omap2 dispc exported functions can then be used by fb, vout
and camera preview code.

o V4L2 based Video out patch. [omap24xxvout.[ch]]
  o This framework implements
    o Dynamic use of video planes 
      e.g As per the 2.6.9-TI code,
      in camera driver V1 was fixed for preview.
      
      Now for camera preview _or_ video out on (LCD/TV) can
      dynamically take the plane which is free.
    o video plane linking [Jian can explain on this...]
    o and rotation/mirroring/colorkey...etc.

o omap24xxlib.[ch]
- It includes functions common between camera preview and vout.
(cropping/scaling)

Attached patch works with 2.6.9-TI omap24xxfb (considering that it uses
the display.[ch] library) driver.

I am *not* able to successfully test this driver along with
git-omap2-fb driver. See I have disabled request_irq, dispc
reset/initialisation in the omap2_disp_init(dispc.c) patch.

But as git-omap2-fb driver is checking FIFO_UNDERFLOW/SYNC_LOST
interrupts, which I am getting more than five times, which ultimately
disables the display irq (irq_status 0x4000, 0x40a2, 0x4002....), and
my test-application(e.g streaming yuv on v1) hangs the system after
that...

So, could you please have look at the patch, so that we can find better
way to integrate vout and display controller library functions into the
git tree. Thanx.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-761951586-1134636072=:8193
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-761951586-1134636072=:8193--
