From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC/PATCH 0/7] decouple platform_device from omap_device
Date: Thu, 28 Jul 2011 10:20:57 +0530
Message-ID: <20110728045057.GA31297@manju-desktop>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <20110727140457.GA8558@manju-desktop>
 <CALyTGODe8r9zr4fA+AX=-XhpLjNXKtfHzxFUWMNSehDawEDMBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37049 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751824Ab1G1EvM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jul 2011 00:51:12 -0400
Received: by mail-pz0-f52.google.com with SMTP id 13so3843048pzd.39
        for <linux-omap@vger.kernel.org>; Wed, 27 Jul 2011 21:51:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALyTGODe8r9zr4fA+AX=-XhpLjNXKtfHzxFUWMNSehDawEDMBA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Wed, Jul 27, 2011 at 02:45:33PM -0700, Hilman, Kevin wrote:
> Hi Manjunath,
>=20
> On Wed, Jul 27, 2011 at 7:04 AM, G, Manjunath Kondaiah <manjugk@ti.co=
m> wrote:
> > Kevin,
> >
> > On Thu, Jul 21, 2011 at 04:52:10PM -0700, Kevin Hilman wrote:
> >> Here's a first whack, proof-of-concept on how we could start to
> >> decouple the platform_device from an omap_device.
> >>
> >> The main RFC is in the last patch, and everything leading up to it=
 are
> >> misc. omap_device cleanups that make the last patch cleaner and
> >> clearer. =A0It's really the last patch that does the decoupling.
> >>
> >> This will be necessary if we're going to decouple the platform_dev=
ice
> >> creation from the omap_device/omap_hwmod creation etc. =A0This pat=
ch
> >> leaves them both done in omap_device_build(), but shows that they =
can
> >> be decoupled.
> > Can you pls mention baseline used for these patches? I tried applyi=
ng on
> > latest mainline, v3.0 and =A0git://git.pwsan.com/linux-2.6 prcm-dev=
el-3.1
>=20
> Oops, sorry.  I forgot to mention it.
>=20
> Due to some misc. dependencies (mainly on Beagle board file), I've
> temporarily based it on the for-next branch of the arm-soc tree[1]
> since that has everything already queued for the next merge window. I
> also based it on the omap_device patch I posted which changes the pr_=
*
> prints to dev_*.
>=20
> For convenience, I've pushed this series to the 'wip/od-devres' branc=
h
> of my tree[2].
>=20
> Sorry for the confusion,
>=20
> Kevin
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.g=
it
>=20
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-=
pm.git

This series results in boot crash. However, it boots fine without this =
series.=20
I have not tried to debug but it looks like from boot log, the res stru=
cture has
invalid entries in mmc probe. As mentioned by Grant in 7/7, the scope o=
f devres=20
is not lifetime hence it needs to be fixed.

The bootlog @ http://paste.ubuntu.com/653527/

-M

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
