From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [RFC]  Display subsystem design for OMAP2 - 3
Date: Sun, 17 Dec 2006 23:17:41 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4708DF02@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

The Display Sub System (DSS) in OMAP2 & 3 platforms have lots of
potential features that we haven't explored yet (Example: VRFB based
Rotation, mirroring, windowing, cropping, camera preview, DSS effective
bandwidth, TV-out for PAL / NTSC standards etc). The existing OMAP
framebuffer driver (which is the only OMAP DSS driver) doesn't address
most of these.=20

I would like to propose the following Display Subsystem driver
architecture for OMAP2 and OMAP3 platforms. It might take some time of
yours to review and comment on design, but it would be a real help to
OMAP community. This would provide OMAP users an opportunity to think
and design the OMAP based systems in much more effective way.=20

1. Please feel free to comment on this design
2. Once design is frozen, we need to discuss on modifying the code and
try to fit in the design.
3. I can work on coding aspects, but need your consistent support to
correct me when-ever / where-ever required.

Thanks in advance,
Khasim

Design:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D

Framebuffer --> omap24xx_fb  --(GFX)-----------> \
                                                  \            |-> LCD
          |---> Video driver --(VID-1/2)-> ----> display_lib---|
V4L-2-----|                                       /            |-> TV
          |---> Camera driver--(for preview)---> /               ^
                                                                 |=20
SYSFS / IOCTL ---------> Board & output Control driver------------

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D

Minimal description is below,

There are totally 4 drivers and one centralized display library.=20

omap24xxfb: This is registered with FBDEV subsystem and manages the
graphics pipeline of OMAP DSS. Supports RGB24 (unpacked) / 16 / CULT
(RGB8) bit formats, rotation support using VRFB, mirroring, other usual
FB operations etc

Video driver: Registered with V4L2. This manages the Video 1 & 2
pipelines of OMAP DSS. Supports both the pipelines, supported image
formats are YUYV,RGB565/24 packed and unpacked, UYVY, Rotation (0
/180/90/270 degrees) using VRFB, mirroring, windowing, cropping,
transparency color key, linking of two pipelines to render same data
simultaneously,etc

Board & Output control driver: This driver controls board specifics such
as LCD panel, backlight control, LCD data lines (16 or 18 lines), TV
standards NTSC/PAL, dithering, etc. Supports SYSFS/IOCTL entries to
dynamically enable & disable any functionality (Example dithering ON/OFF
control, Backlight ON/OFF, TV standard selection etc).=20

Camera Driver: In the preview mode, camera driver requests a video layer
and previews the image directly on to LCD or TV with out the
intervention of apps (for data handling).

Display Library: This is the code that abstracts OMAP2 or 3 display
hardware. All accesses to display hardware are done through this
library. Supports VRFB based rotation algorithm, centralized interrupt
handler to support all three pipelines, SYNC LOST interrupt handlers,
TV-out support, Video encoder configurations for different TV standards,
APIs to support RFBI etc.

Please do let me know if you need more explanations on any of these.
