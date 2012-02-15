From: =?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Wed, 15 Feb 2012 13:02:49 +0100
Message-ID: <20120215120249.GC24331@lit.local.igalia.com>
References: <CAMP44s2HUApzGH_rExqS1bOnq0nHj4Y0vEojZN4vXNPAxC1oKA@mail.gmail.com>
 <20120210203537.GG4141@mwanda>
 <CAMP44s2OEvn7RVpwJ2zkdkxrzwrbD3+PFQbzYiOG-hvnrc4UhA@mail.gmail.com>
 <CAB-zwWhSoiMNVGQ=u=6-Umte-AaP9Qih8QMJFTyk8pjXaXysLg@mail.gmail.com>
 <CAMP44s1yY8N4z_uF1b=DKdEMGXORJUhkytEpbK2AoCSTbmiJNw@mail.gmail.com>
 <CAB-zwWjtPcdwAfQGW6iB-pLWVuM1S0YJS7ioVv_voYZH2wNM9Q@mail.gmail.com>
 <CAMP44s3sNH2qRsMHxgCbemefVye=z5E8XFLnSPvUtgA94SoV=A@mail.gmail.com>
 <CAB-zwWjkCqehNAKp=gFt6Zq=XR+Mscz67oGnfY2sPjgvgpvNFQ@mail.gmail.com>
 <20120215094357.GA24331@lit.local.igalia.com>
 <CAMP44s2Xg5P7-+4NPq8tBqk=gSu9T8kvzSpEh_rj6wiZT+qcKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.mundo-r.com ([212.51.32.151]:48996 "EHLO
	smtp4.mundo-r.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787Ab2BOMCy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 07:02:54 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s2Xg5P7-+4NPq8tBqk=gSu9T8kvzSpEh_rj6wiZT+qcKQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <gregkh@linuxfoundation.org>

On Wed, Feb 15, 2012 at 01:41:19PM +0200, Felipe Contreras wrote:
> 2012/2/15 V=EDctor M. J=E1quez L. <vjaquez@igalia.com>:
> > On Tue, Feb 14, 2012 at 08:56:11PM -0600, Ramirez Luna, Omar wrote:
> >> On Tue, Feb 14, 2012 at 10:23 AM, Felipe Contreras
> >> <felipe.contreras@gmail.com> wrote:
> >> >> When that case is applicable, we should first modify the loader=
 code
> >> >> or prepare the baseimages to be common so we can get rid of spe=
cific
> >> >> loaders and just dump them into memory.
> >> >
> >> > I'd say the less workarounds, the better.
> >>
> >> If there are ever more base images compatible with the dsp, I woul=
d
> >> say that unifying them into a common format to be dumped in memory
> >> isn't a workaround, and in that process we can get rid of the cust=
om
> >> loader code.
> >
> > Yes! please! and use Ohad's rproc thingy.
>=20
> I thought rproc is tied to elf for now.

It is.

>=20
> > What would be the steps to unify that common format? I guess we wil=
l depend on
> > TI for that... Do we?
>=20
> But this "common" format would be specific for tidspbridge, I don't
> think it makes sense for these images to have that constraint.
> Certainly rproc doesn't have it, and that one is not on staging.
>=20
> In any case, the proposed patch looks good. We can deal about these
> futuristic situations later on.

I do agree.

vmjl
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
