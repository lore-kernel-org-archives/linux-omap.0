From: "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>
Subject: Re: [RFC 0/9] OMAP3 ISP and camera drivers
Date: Thu, 5 Mar 2009 14:00:04 +0900
Message-ID: <5e9665e10903042100k2cf32aa0nbb8e488b6803a290@mail.gmail.com>
References: <49AD0128.5090503@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:26134 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbZCEFAG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 00:00:06 -0500
In-Reply-To: <49AD0128.5090503@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Toivonen Tuukka Olli Artturi <tuukka.o.toivonen@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hi Sakari,

Reviewing your driver, I couldn't find JPEG sync mode or where to make
programme ISP_CTRL with ISPCTRL_JPEG_FLUSH.
Is JPEG sync mode is not the coverage of this version? or I'm missing s=
omething.
If JPEG sync mode is not considered yet please let me know.
Cheers,

Nate

On Tue, Mar 3, 2009 at 7:06 PM, Sakari Ailus
<sakari.ailus@maxwell.research.nokia.com> wrote:
> Hi,
>
> So here's the patchset for OMAP 3 ISP and camera drivers plus the
> associated V4L changes. Sergio Aguirre has been posting a related
> patchset earlier, containing also sensor and lens driver used on SDP.=
 This
> patchset is agains the linux-omap tree:
>
> <URL:http://www.muru.com/linux/omap/README_OMAP_GIT>
>
> So I and Sergio have synchronised our versions of the ISP and camera
> drivers and this is the end result. There is still a lot of work to d=
o,
> though. You can find some comments in individual patch descriptions. =
If the
> todo list for a patch is empty it doesn't mean there wouldn't be anyt=
hing
> left to do. ;)
>
> There's at least one major change to Sergio Aguirre's earlier patches=
 which
> is that the ISP driver now uses the IOMMU from Hiroshi Doyu. Hiroshi =
is away
> for some time now so there are just some hacks on top of Hiroshi's ol=
der
> iommu patches to use with current linux-omap.
>
> This patchset does not contain the resizer or preview wrappers from T=
I but
> they have been left intentionally out. A proper interface (V4L) shoul=
d be
> used for those and the camera driver should be somehow involved --- t=
he
> wrappers are just duplicating much of the camera driver's functionali=
ty.
>
> I don't have any sensor or lens drivers to publish at this time.
>
> This patchset should work with the SDP and OMAPZoom boards although y=
ou
> need the associated sensor drivers + the board code from Sergio Aguir=
re to
> use it. You'll also need the IOMMU patchset from Hiroshi Doyu. Everyt=
hing
> except the sensor / board stuff is available here:
>
> <URL:http://www.gitorious.org/projects/omap3camera>
>
> In short, on linux-omap:
>
> $ git pull http://git.gitorious.org/omap3camera/mainline.git v4l \
> =A0iommu omap3camera base
>
> Hiroshi's original iommu tree is here (branch iommu):
>
> <URL:http://git.gitorious.org/lk/mainline.git>
>
> Some of the camera and ISP driver development history is available, t=
oo. See
> the first link.
>
> Any feedback is appreciated.
>
> Sincerely,
>
> --
> Sakari Ailus
> sakari.ailus@maxwell.research.nokia.com
>
>



--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
DongSoo(Nathaniel), Kim
Engineer
Mobile S/W Platform Lab. S/W Team.
DMC
Samsung Electronics CO., LTD.
e-mail : dongsoo.kim@gmail.com
          dongsoo45.kim@samsung.com
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
