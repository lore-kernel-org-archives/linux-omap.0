From: "Khasim, Syed" <x0khasim@ti.com>
Subject: RE: [RFD] [PATCH] omap24xx vout and dispc library
Date: Thu, 15 Dec 2005 08:43:59 -0600
Message-ID: <2B486F5800B5A8428350207E391C3BEB01903EBD@dlee03.ent.ti.com>
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
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Video plane linking is a software implementation to render similar image
data simultaneously through both V1 and V2 pipelines.

Use case Example: if v1 is connected to LCD and V2 is connected to TV,
When a link is ON (V2 linked to V1), an image displayed through V1 on
LCD, is simultaneously displayed TV (through V2, but same data).

Regards,
Khasim.


-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Komal Shah
Sent: Thursday, December 15, 2005 2:41 AM
To: linux-omap-open-source@linux.omap.com
Subject: [RFD] [PATCH] omap24xx vout and dispc library

Imre/Tony,

I have attached the patch (compressed .gz) which includes (done by Jian
and the team...)

o display functions library [display.[ch]].
  - Location: arch/arm/mach-omap2/display.c
  - common omap2 dispc exported functions can then be used by fb, vout
and camera preview code.

o V4L2 based Video out patch. [omap24xxvout.[ch]]
  o This framework implements
    o Dynamic use of video planes=20
      e.g As per the 2.6.9-TI code,
      in camera driver V1 was fixed for preview.
     =20
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
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
