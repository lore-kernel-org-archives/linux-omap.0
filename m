From: Patrick Radius <info@notoyota.nl>
Subject: Re: OMAP 3430 Camera/ISP out of memory error
Date: Sat, 26 Mar 2011 14:32:26 +0100
Message-ID: <AANLkTimat2mzSE_Fsz6OJPwGN70RoBvcUs5rkkgz8bV=@mail.gmail.com>
References: <1301050377.25083.2.camel@kaas>
	<4D8C7B62.9010701@maxwell.research.nokia.com>
	<1301052893.25083.3.camel@kaas>
	<BANLkTik5MCZXWT5mAeAyL8Uh5eGE85-Ynw@mail.gmail.com>
	<1301079693.25083.8.camel@kaas>
	<AANLkTimizTZvkHk=FeSM3hN0O2E42q1wZQNM9NZ7s8AH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <AANLkTimizTZvkHk=FeSM3hN0O2E42q1wZQNM9NZ7s8AH@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Thanks.
I'm still not sure where to find an (the) up-to-date mainline.
I was under the impression there's only one mainline?
Regarding the older kernel, unfortunately I won't be able to choose
for a newer version.
The lead developer for this project did most of the work for the rest
of the device with this kernel allready.
So, I guess it's possible to backport the changes to the older kernel t=
oo right?

Patrick Radius
Noto Yota multimedialab
Mail: =A0 =A0 =A0 =A0info@notoyota.nl
Phone: =A0 =A006-15693122
Web: =A0 =A0 =A0 =A0http://www.notoyota.nl
Skype: =A0 =A0 notoyota
LinkedIn: http://nl.linkedin.com/in/patrickradius


2011/3/26 David Cohen <dacohen@gmail.com>
>
> On Fri, Mar 25, 2011 at 9:01 PM, Patrick Radius <info@notoyota.nl> wr=
ote:
> > Thanks,
> >
> > I'm looking at
> > http://gitorious.org/linux-omap/mainline/trees/master/drivers/media=
/video
> >
> > however, I can't seem to find the drivers I need.
> > I only see omap24xxcam while I was using the omap34xxcam from Linux
> > kernel 2.6.32.9.
> > And I also don't see any M-4MO driver anymore.
> > I'm probably looking at the wrong spot, but...
>
> You need to get an up-to-date mainline kernel. The driver is in the
> directory: drivers/media/video/omap3isp/
> I don't recommend you to use 2.6.32, as it depends on some new V4L2
> stuff which you won't natively find in such old kernel version. I als=
o
> suggest you to CC linux-media@vger.kernel.org as well in next
> questions.
>
> Br,
>
> David
>
> >
> > As you can tell, I'm fairly new with OMAP programming.
> >
> > Thanks!
> >
> > Regards,
> > Patrick
> >
> > On vr, 2011-03-25 at 16:34 +0200, David Cohen wrote:
> >> Hi,
> >>
> >> On Fri, Mar 25, 2011 at 1:34 PM, Patrick Radius <info@notoyota.nl>=
 wrote:
> >> > Ok, thanks!
> >> > However, I'm also quite curious about peoples thoughts about it =
from
> >> > here.
> >> > Since I think what's happing is quite OMAP specific.
> >> > For example, I was wondering where omap34xxcam.c gets it's memor=
y it
> >> > should allocate from.
> >> > Is it the 'main' memory? Or does it share memory with a framebuf=
fer
> >> > (overlay)? Or memory from the (M-4MO) sensor?
> >> > Is it possible I should allocate memory for it as boot argument?=
 similar
> >> > like vmem=3D16M omapfb.vram=3D0:8M
> >> >
> >> > I can't find much information about this all...
> >>
> >> You're using an old version of the driver. Please, use the newer o=
ne
> >> available in mainline.
> >>
> >> Regards,
> >>
> >> David Cohen
> >>
> >> >
> >> > On vr, 2011-03-25 at 13:24 +0200, Sakari Ailus wrote:
> >> >> Patrick Radius wrote:
> >> >> > Hi,
> >> >>
> >> >> Hi Patrick,
> >> >>
> >> >> I think this question will get better answered in the linux-med=
ia list.
> >> >> Cc it.
> >> >>
> >> >> > i'm trying to get camera support working on a relatively new =
Android
> >> >> > port to an OMAP 3430 based phone (Samsung GT-i8320 a.k.a. Sam=
sung H1).
> >> >> > However calls to VIDIOC_REQBUFS fail with a -12 (OUT OF MEMOR=
Y).
> >> >> > As far as I can see this return error isn't even supposed to =
exist,
> >> >> > according to the V4L2 spec.
> >> >> > I'm using the code from Android on the Zoom2.
> >> >> > The sensor is a Fujitsu M-4MO.
> >> >> >
> >> >> > Any ideas on what could be wrong with the out of memory resul=
t?
> >> >>
> >> >> First of all, which version of the driver are you using, i.e. i=
s it the
> >> >> current one going to upstream?
> >> >>
> >> >
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-=
omap" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
> >> >
> >
> >
> >
