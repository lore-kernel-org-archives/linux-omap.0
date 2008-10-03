From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PREVIEW] New display subsystem for OMAP2/3
Date: Fri, 3 Oct 2008 18:17:23 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403DC1A6A02@dbde02.ent.ti.com>
References: <1222935892.6387.52.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <1222935892.6387.52.camel@tubuntu>
Content-Language: en-US
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

Thanks,
Vaibhav Hiremath
Senior Software Engg.
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, October 02, 2008 1:55 PM
> To: Hiremath, Vaibhav
> Cc: Shah, Hardik; linux-omap@vger.kernel.org; video4linux-list@redhat.c=
om
> Subject: RE: [PREVIEW] New display subsystem for OMAP2/3
>=20
> Hi Vaibhav,
>=20
> On Wed, 2008-10-01 at 16:21 +0530, ext Hiremath, Vaibhav wrote:
> > Tomi,
> >
> > Have you got a chance to review the DSS library and V4l2 driver which=
 we have posted?
>=20
> Unfortunately not very much. I've been glancing the DSS side of the
> driver, but not the v4l side as I don't know much about it.
>=20
> There seems to be awfully lot ifdefs for board/cpu types in the code.

As far as ifdefs are concerned, they are added to take care of OMAP2/3 va=
riants. Especially you will find many instances of CONFIG_ARCH_OMAP3410 a=
nd the reason is obvious, OMAP3410 doesn't have VENC. As I have mentioned=
 before, DSS library is designed to support both LCD, TV, and many more.

> Also there are strange things defined, like L4_VIRT
>=20

You are right; the code requires little-bit cleaning. There are some macr=
os defined which driver or library doesn't use. We are in the process of =
cleaning and soon will be posting patches.

> My biased and superficial view of the differences between my DSS and
> yours is that:

Tomi, here I differ from you. There should not be biased opinion. What we=
 are looking here is a good design which will fulfill all our requirement=
s/use case, like LCD, DVI, HDMI and TV for us and DSI, RFBI for you.

> - My implementation is cleaner, better organized and more generic

Again, here both of us will be having biased comments to support our own =
design, so I would prefer not to comment on this. Lets people on the comm=
unity decide whose design is better.

> - My implementation has support for DSI, SDI, RFBI, L4 updates

DSI, SDI and RFBI are the modes, which we can add anytime to the system d=
epending as per our requirement.=20
It is again driven by use case; you have use cases for DSI, SDI and RFBI.=
 We have for TV, DVI, HDMI and LCD, so we strongly concentrated on these.=
=20

We can very well add these supports to DSS Library with minimal effort.

> - Your implementation has better support for "extra" things like VRFB,
> color conversions, alpha etc.
> - Your implementation most likely has better power management support.
> - And of course what is most visible to the user, my version uses only
> framebuffers, and yours uses also v4l2 devices.
>=20

You really can't deny the V4L2 framework advantages over framebuffer, esp=
ecially for streaming kind of applications. Looking towards the hardware =
features OMAP supports; we would really require to have such support/capa=
bilities. Community is also in agreement for the V4L2 interface on OMAP-D=
SS.

Tony/Hans,
Your comments would be helpful here.

> As for the future, I have no choice but to keep using my DSS as we need
> the features it has. I feel it would be quite a big job to get those in
> to your driver. And even if I had a choice, I (unsurprisingly =3D) thin=
k
> that my version is better and would stick to it.
>=20

It's your personal choice to stick to whichever code base you want, I don=
't want to comment on that. But what I believe is, with your design we ar=
e limiting ourselves from supporting most of the features which hardware =
provides.=20

We can work together to add more support to DSS library.=20

> Have you had time to look at my code after I changed the overlay
> handling? I've put the most recent version to a public git tree at
> http://www.bat.org/~tomba/git/linux-omap-dss.git/ and I'll try to keep =
that up to date.
>=20

Definitely I will review this code base, and will appreciate if I found s=
omething good.

>  Tomi
>=20
> >
> > Thanks,
> > Vaibhav Hiremath
> > Senior Software Engg.
> > Platform Support Products
> > Texas Instruments Inc
> > Ph: +91-80-25099927
> >
> > > -----Original Message-----
> > > From: Hiremath, Vaibhav
> > > Sent: Monday, September 15, 2008 9:51 PM
> > > To: 'Tomi Valkeinen'
> > > Cc: Shah, Hardik; linux-omap@vger.kernel.org; video4linux-list@redh=
at.com
> > > Subject: RE: [PREVIEW] New display subsystem for OMAP2/3
> > >
> > >
> > >
> > > Thanks,
> > > Vaibhav Hiremath
> > > Senior Software Engg.
> > > Platform Support Products
> > > Texas Instruments Inc
> > > Ph: +91-80-25099927
> > > TI IP Ph: 509-9927
> > > http://dbdwss01.india.ti.com/pspproducts/
> > >
> > > > -----Original Message-----
> > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@v=
ger.kernel.org] On Behalf Of
> Tomi
> > > > Valkeinen
> > > > Sent: Monday, September 15, 2008 8:08 PM
> > > > To: Hiremath, Vaibhav
> > > > Cc: Shah, Hardik; linux-omap@vger.kernel.org; video4linux-list@re=
dhat.com
> > > > Subject: RE: [PREVIEW] New display subsystem for OMAP2/3
> > > >
> > > > On Mon, 2008-09-15 at 19:02 +0530, ext Hiremath, Vaibhav wrote:
> > > >
> > > > > We more concentrated on TV and LCD interface, out design doesn'=
t support DSI as of now. As
> > > > mentioned earlier it is easily extendible to support DSI.
> > > > >
> > > > > If I understand your implementation correctly, right now there =
is no way you can switch the
> > > > outputs, I mean to say from LCD to DVI. The frame buffer driver g=
ets the handle with API
> > > > omap_dss_get_display, which will return pointer to omap_display f=
or panel-sdp3430. Henceforth
> all
> > > > your functions will use omap_display configuring for LCD panel. H=
ow are you planning to add
> support
> > > > for this? Through some ioctls or sysfs entry? How about switching=
 between multiple overlay
> > > managers?
> > > >
> > > > You can switch the outputs in the DSS driver. You can enable/disa=
ble
> > > > displays individually, and configure the planes and or L4 pixel s=
ource
> > > > for the display.
> > > >
> > > > But yes, the fb driver does not support that currently.
> > > >
> > > > One idea I had was to present each display with one framebuffer, =
so
> > > > let's say we have 3 displays, we would have fb[0-2]. In addition =
to
> > > > that, we would have two framebuffers for the video overlays. Only=
 one of
> > > > the displays can be updated with DISPC, so the overlays would app=
ear
> > > > there.
> > > >
> > > > Then the display that is updated with DISPC could be changed on t=
he fly
> > > > to another one, but the framebuffer arrangement would stay the sa=
me (so
> > > > fb0 would still be seen on display0, even if it's now updated wit=
h L4).
> > > >
> > > > There's still the question how to manage the video overlays, in t=
his
> > > > scenario they would automatically move to other LCD's as the DISP=
C
> > > > target is changed. Also the TV-out is problematic.
> > > >
> > > > > This issue has been addresses with our design, you can change t=
he output either to TV, LCD or
> to
> > > > DVI through sysfs entry. Switching between multiple overlay manag=
ers is very well supported in
> DSS
> > > > library. Currently SYSFS is the user interface layer to control t=
he overlay managers. But in
> future
> > > > DSS library will easily be suitable to support media processor in=
terface which is in concept
> phase
> > > > right now.  RFC for the media processor is at
> > > >
> > > > Does your design support displays that are not updated with DISPC=
?
> > >
> > > Yes, it should. I don't see any reason why it should fail if the di=
splay is completely
> independent.
> > >
> > > >
> > > > Your design has good points. I have to think about the overlay ma=
nagers
> > > > a bit more. Especially if in some future hardware there were more
> > > > overlay managers instead of the current two.
> > > >
> > >
> > > Let me take this opportunity, shortly I will post the DSS library a=
nd V4L2 driver. We can work
> > > together to add support for DSI, RFBI and SDI support to it.
> > >
> > > > > http://lists-archives.org/video4linux/23652-rfc-add-support-to-=
query-and-change-connections-
> > > inside-
> > > > a-media-device.html
> > > > >
> > > > >
> > > > > > I also wanted to be able to change the configuration on the f=
ly,
> > > > > > changing where DISPC output is going and which displays are u=
pdated with
> > > > > > CPU or sDMA.
> > > > > >
> > > > > > This is why I have the display-concept in my design.
> > > > > >
> > > > >
> > > > >
> > > > > Here we both are on same page, you have broken the displays and=
 modes supported into multiple
> > > files
> > > > registering functions to the display.c file, there are many looph=
oles though.
> > > > >
> > > > > > I haven't made support for multiple users of the displays (li=
ke separate
> > > > > > fb and v4l drivers), but I don't immediately see why it could=
n't be
> > > > > > done.
> > > > > >
> > > > >
> > > > > How are you going to handle the concurrency between these two?
> > > >
> > > > In the simple case of just an LCD and a TV-out, what are the conc=
urrency
> > > > problems? Each plane is independent of each other. Sure you need =
to
> > > > check that the output is on if there's a plane enabled there and =
basic
> > > > things like that. Are there some other issues I'm not seeing?
> > > >
> > >
> > > Yes some of the features of the DSS are tied to overlay managers an=
d not the individual planes
> like
> > > global alpha, alpha blending enabling and timing parameters. So whi=
le programming of these
> parameters
> > > DSS library will have to maintain the data structures for the same =
and then any high level
> drivers
> > > can query those data structures.
> > >
> > > > > > However, there are some questions regarding that, as the plan=
es do not
> > > > > > represent displays, but just overlay planes. What happens whe=
n both fb
> > > > > > and v4l drivers want to change the resolution or timings of t=
he display?
> > > > > >
> > > > > > Also I still don't quite know how to present displays to user=
 space.
> > > > > > Currently my omapfb just uses the first display, and that's i=
t. I think
> > > > > > in the end the user (be it X server, or perhaps some entity o=
ver it),
> > > > > > needs to have some understanding of what OMAP offers and how =
it can use
> > > > > > the displays. And there probably needs to be some product spe=
sific
> > > > > > configuration regarding this in userspace.
> > > > > >
> > > > >
> > > > > Here are you saying application will have hardware specific sup=
port? Is this feasible?
> > > > >
> > > >
> > > > I don't see any other way. The displays are not independent of ea=
ch
> > > > other.  For example the OMAP3 SDP has LCD and DVI outputs. They c=
an't be
> > > > switched programmatically, but let's say it was possible. Only on=
e of
> > > > those displays can be enabled at time. If an application wants to=
 use
> > > > them both, it has to understand that they will not both work at t=
he same
> > > > time.
> > > >
> > > > Or if there are two DSI displays, and one is updated with DISPC a=
nd the
> > > > other via L4. The application has to know that a video overlay ca=
n only
> > > > be used on the first display, or it has to exchange the DISPC/L4
> > > > updating order.
> > > >
> > > > Of course this is product specific software and configuration, no=
t
> > > > something I'm planning to put in the driver. A normal application=
 does
> > > > not have to know anything about it. I was just bringing it up to
> > > > demonstrate what must be possible.
> > > >
> > > >  Tomi
> > > >
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-o=
map" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >
>=20


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
