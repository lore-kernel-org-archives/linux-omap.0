From: k c <omap_mails@hotmail.com>
Subject: RE: 2420 2.6 open source kernel + color space coversion
Date: Wed, 12 Dec 2007 08:51:39 +0000
Message-ID: <BAY119-W42FAF389579D5EABC5DAF5F9650@phx.gbl>
References: <BAY119-W828D01D8E6A90E786AAD7F9640@phx.gbl>
	<7EAD1AEEA7621C45899FE99123E124A001487F2F@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A001487F2F@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I can assume all the DSS register offsets are same between 2420 and 2430 ri=
ght ?
=20
Regards,
k c



> Subject: RE: 2420 2.6 open source kernel + color space coversion> Date: T=
ue, 11 Dec 2007 23:20:13 +0530> From: khasim@ti.com> To: omap_mails@hotmail=
.com; linux-omap-open-source@linux.omap.com> > > > > -----Original Message-=
----> > From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-o=
map-> > open-source-bounces@linux.omap.com] On Behalf Of k c> > Sent: Tuesd=
ay, December 11, 2007 9:43 PM> > To: linux-omap-open-source@linux.omap.com>=
 > Subject: 2420 2.6 open source kernel + color space coversion> > > > Hi,>=
 > > > In the 2.6.9 open source kernel for OMAP2420 there is no support to =
set> > the display controller color conversion on the video pipeline. There=
 are> > not IOCTL's implemented for this. The 2430 open source kernel has a=
n IOCTL> > VIDIOC_S_OMAP2_COLORCONV implemented in> > ./drivers/media/video=
/omap/omap24xxvout.c.> > > > Can anyone let me know if I can find that supp=
ort for OMAP2420 or do I> > have to implement that myself.> > > > If you ar=
e looking for 2430 kind of dss functionality, then unfortunately yes, you h=
ave to port the 2430 DSS drivers back. > > But, it's quite straight. Copy t=
he following files> > drivers/media/video/omap24xxvout.c> drivers/media/vid=
eo/omap24xxvout.h> drivers/media/video/omap24xxvoutdef.h> drivers/video/oma=
p/omap24xxfb.c> drivers/video/omap/omap2_disp_out.c> arch/arm/plat-omap/dis=
play.c to drivers/video/omap/display.c> include/asm-arm/arch-omap/display.h=
> include/asm-arm/arch-omap/venc.h> > Corresponding makefiles and Kconfigs =
have to be updated.> > Regards,> Khasim
_________________________________________________________________
Tried the new MSN Messenger? It=92s cool! Download now.
http://messenger.msn.com/Download/Default.aspx?mkt=3Den-in=
