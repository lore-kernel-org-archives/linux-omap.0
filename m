From: "Sideleau, Scott R" <srs@WPI.EDU>
Subject: Help with LCD on OSK
Date: Wed, 4 Oct 2006 12:29:37 -0400
Message-ID: <CC7B089C59ED6841BAE28F1EA69A854387371D@EXCHDB.admin.wpi.edu>
References: <fb249edb0610040855n61953dc7s8a23c2683aaeb825@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <fb249edb0610040855n61953dc7s8a23c2683aaeb825@mail.gmail.com>
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

I was hoping I might be able to get some assistance with getting an =
external,
custom LCD working with the OSK.  It's driver board currently connects =
to the
OSK via the 80-pin HiRose connector to Expansion Slot C on the OSK.

It's a grascale video LCD (320x240 from Hantronix) with it's 4x data =
lines
connected to LCD.P2, LCD.P4, LCD.P6, and LCD.P8.

I've looked at lcd_osk.c and lcdc.c in .../arch/arm/drivers/plat-omap, =
but do
not readily see what I need to modify to get things working.

In addition, I do not know how to tell if the driver is installed and =
loading
correctly with my current kernel.

Any help and/or direction (to documentation or otherwise) would be =
greatly
appreciated.  As this is a university project, I'm on a tight schedule =
and
would appreciate any response... really.

Thanks in advance.
______________________________________________
Scott R. Sideleau
ECE '07, Worcester Polytechnic Institute
@ MQP Ireland A'06, University of Limerick
+353 61-307310 / srs@wpi.edu
