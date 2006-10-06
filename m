From: "Sideleau, Scott R" <srs@WPI.EDU>
Subject: RE: Bug? - OSK Frame Buffer Support in Kernel 2.6.18-omap1
Date: Fri, 6 Oct 2006 12:13:08 -0400
Message-ID: <CC7B089C59ED6841BAE28F1EA69A854387372D@EXCHDB.admin.wpi.edu>
References: <45263357.7090700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <45263357.7090700@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello,

Thanks for the reply, Dirk.

> With patch I sent some minutes ago most recent git works for=20
> me on OSK with frame buffer and Mistral LCD.
>
> Do you use recent git? What are your errors?

I was quite certain I was not using the latest Git, so I've spent most =
of the
day updating everything.  I grabbed the latest 2.6.18-omap1 kernel from =
the
repository (and put it in a completely new place) via:

git-clone git://source.mvista.com/git/linux-omap-2.6.git

I'm quite certain I have the absolute latest git right now.  I then =
chose the
proper frame buffer support via 'make menuconfig' that I then compared
against your list.  From your list, the following lines match in my =
.config
file:

CONFIG_VIDEO_V4L2=3Dy
CONFIG_FB=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_OMAP=3Dy
CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=3D2

The following lines simply do not exist in my .config file (even =
commented
out, as they should appear if I didn't select them):

CONFIG_OMAP_OSK_MISTRAL=3Dy
CONFIG_FB_OMAP_DMA_TUNE=3Dy

I just attempted another compile and it failed at the same point in
'omapfb_main.c'.  Here's an excerpt of the errors dumped to my terminal:

=3D=3D=3D=3D=3D
drivers/video/omap/omapfb_main.c:1558: error: request for member
=1B$(B!F=1B(Bfb_info=1B$(B!G=1B(B in something not a structure or union
drivers/video/omap/omapfb_main.c:1558: warning: passing argument 1 of
=1B$(B!F=1B(Bomapfb_blank=1B$(B!G=1B(B makes integer from pointer =
without a cast
drivers/video/omap/omapfb_main.c:1558: warning: passing argument 2 of
=1B$(B!F=1B(Bomapfb_blank=1B$(B!G=1B(B makes pointer from integer =
without a cast
drivers/video/omap/omapfb_main.c: In function =
=1B$(B!F=1B(Bomapfb_setup=1B$(B!G=1B(B:
drivers/video/omap/omapfb_main.c:1609: error: assignment of read-only
location
drivers/video/omap/omapfb_main.c: In function =
=1B$(B!F=1B(Bomapfb_init=1B$(B!G=1B(B:
drivers/video/omap/omapfb_main.c:1638: warning: implicit declaration of
function =1B$(B!F=1B(Bfb_get_options=1B$(B!G=1B(B
drivers/video/omap/omapfb_main.c: At top level:
drivers/video/omap/omapfb_main.c:1657: error: invalid operands to binary =
/
drivers/video/omap/omapfb_main.c:1657: error: initializer element is not
constant
drivers/video/omap/omapfb_main.c:1657: error: (near initialization for
=1B$(B!F=1B(B__param_arr_vram.max=1B$(B!G=1B(B)
drivers/video/omap/omapfb_main.c:1657: error: initializer element is not
constant
drivers/video/omap/omapfb_main.c:1657: error: (near initialization for
=1B$(B!F=1B(B__param_arr_vram.elem=1B$(B!G=1B(B)
make[3]: *** [drivers/video/omap/omapfb_main.o] Error 1
make[2]: *** [drivers/video/omap] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2
=3D=3D=3D=3D=3D

Any help would be appreciated.  Thanks, in advance.
______________________________________________
Scott R. Sideleau
ECE '07, Worcester Polytechnic Institute
@ MQP Ireland A'06, University of Limerick
+353 61-307310 / srs@wpi.edu
=20
