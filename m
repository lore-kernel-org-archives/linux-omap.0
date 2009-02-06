From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [REVIEW PATCH 00/14] OMAP3 camera + ISP + MT9P012 sensor driver
 v2
Date: Fri, 6 Feb 2009 23:02:11 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA81B22F@dbde02.ent.ti.com>
References: <498C513E.6080501@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <498C513E.6080501@maxwell.research.nokia.com>
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
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "Ailus Sakari (Nokia-D/Helsinki)" <Sakari.Ailus@nokia.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Toivonen Tuukka.O (Nokia-D/Oulu)" <tuukka.o.toivonen@nokia.com>, "Nagalla, Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Sakari Ailus [mailto:sakari.ailus@maxwell.research.nokia.com]
> Sent: Friday, February 06, 2009 8:33 PM
> To: Hiremath, Vaibhav
> Cc: Ailus Sakari (Nokia-D/Helsinki); Aguirre Rodriguez, Sergio
> Alberto; Nagalla, Hari; video4linux-list@redhat.com; linux-
> omap@vger.kernel.org; Toivonen Tuukka.O (Nokia-D/Oulu); linux-
> media@vger.kernel.org
> Subject: Re: [REVIEW PATCH 00/14] OMAP3 camera + ISP + MT9P012
> sensor driver v2
>=20
> Hiremath, Vaibhav wrote:
> > [Hiremath, Vaibhav] Sakari, Can you share your version of code
> > (either in form of patches or source) here onto the mailing list,
> so
> > that everybody those who are interested will be aware of changes?
>=20
> I will synchronise soon with Sergio (as he noted). After that we'll
> send
> a new patchset. I was thinking of separating the ISP and camera
> driver
> patches from other hardware dependent patches. The resulting
> patchset
> wouldn't be that huge anymore but on the other hand it wouldn't be
> very
> usable as such.
>=20
[Hiremath, Vaibhav] How much change can we expect as compared to the patc=
hes posted by Sergio on 14th Jan?

> > Atleast for me I would get prior view of changes which might
> affect
> > BT656 support (posted on top of Sergio's patch).
> >
> > Again one more thing I would like to bring to your notice is about
> > sub-device framework. Also we need to plan for the migration from
> > V4L2-int to sub-device framework, which is of equal important. I
> feel
> > the more time we spend in merging and aligning offline, more we
> are
> > carrying risk.
>=20
> I agree that we should be moving to v4l2 sub-device at some point,
> preferrably sooner than later, but I think the ISP driver should get
> a
> much much better interface than it currently has. So that should be
> part
> of the task.
>=20
> > According to me as I mentioned before, the plan should be to push
> > ISP-Camera with V4L2-int interface as early as possible with
> whatever
> > minimal sensor/decoder support we have today, which will make sure
> > that our underneath ISP-library is in place. Once that is placed
> in,
> > we can have additional patches on top of it to add more features.
>=20
> I agree. But I'd say that fixing the bugs and cleaning up the code
> is as
> least as important than adding new features.
>=20
[Hiremath, Vaibhav] It would be really great if you could share your plan=
 of action for ISP-Camera driver that would really help to plan our miles=
tone accordingly.

> > In this way, we can plan for migration to sub-device framework and
> > also be easier and simpler. Even if any customers are interested,
> > they can pick it up the ISP library and start development on top
> of
> > it.
>=20
> There's still a long way to get there --- the ISP driver's current
> interface and internals don't mix well with either v4l2 sub-device
> or
> v4l2-int-if. For example, there's no ISP object, just function calls
> and
> then output frame size / frame interval enumeration doesn't work
> properly for YUV (maybe not even for RAW10). Enumerating frame size
> has
> side effects. The ISP driver doesn't have a standard interface, it's
> now
> specific to OMAP 3. And this is just an example...
>=20
> Regards,
>=20
> --
> Sakari Ailus
> sakari.ailus@maxwell.research.nokia.com


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
