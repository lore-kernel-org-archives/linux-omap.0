From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] of/platform: Allow secondary compatible match in of_dev_lookup
Date: Thu, 07 Apr 2016 14:15:56 +0300
Message-ID: <87d1q1r7o3.fsf@intel.com>
References: <1459546504-32668-1-git-send-email-tony@atomide.com> <20160401214053.GQ9329@atomide.com> <CAL_Jsq+PcTD=duHmWgHyx_ywYbT10vEtcm=79x5o5wYSkgG63g@mail.gmail.com> <5706348C.1040709@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5706348C.1040709-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
> On 04/07/2016 07:52 AM, Rob Herring wrote:
>> On Fri, Apr 1, 2016 at 4:40 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>>> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160401 14:37]:
>>>> We currently try to match of_dev_auxdata based on compatible,
>>>> IO address, and device name. But in some cases we have multiple
>>>> instances of drivers that can use the same auxdata.
>>>>
>>>> Let's add an additional secondary lookup for generic compatible
>>>> match for auxdata if no device specific match is found. This does
>>>> not change the existing matching, and still allows adding device
>>>> specific auxdata.
>>>>
>>>> This simplifies things as specifying the IO address and device
>>>> name is prone errors as it requires maintaining an in kernel
>>>> database for each SoC.
>>>
>>> And here's what I can apply later on to get rid of some
>>> ifdeffery.
>>>
>>> I'm also planning to move some of the legacy omap hwmod
>>> functionality into proper device drivers, so can generic
>>> pdata for that too.
>>=20
>> Why can't the platform data be moved into the driver given that it
>> appears to be only SoC family specific? Auxdata was somewhat intended
>> to be temporary. It appears there is already some per compatible match
>> data for these OMAP parts in the driver.
>>=20
>
> Most probably this is required to pass some data from parent device to
> children when parent dev instantiate children from DT, at least I've expe=
rimented with
> this in mostly similar way (I've not added second pass and did break in t=
he first
> if !phys_addr, but Tony's patch is more correct).
>
> For example,
> - USB dwc3 platform/integration layer dev creates DWC3-core device (of_pl=
atform_populate())
> - DWC3-core device creates xhci device
> - USB dwc3 platform/integration layer dev can dynamically get rev info
>   from HW and identify limitation/erratas/quirks which need to be applied=
 to=20
>   to its children.
> - DWC3-core can dynamically get rev info ...
>
> I was not able to find any other proper way to pass this (platfrom)data t=
o children, except
> using Auxdata. And, as per Felipe Balbi, It was the major reason why now
> DWC3-core device creates xhci device manually.

doesn't device_property() solve that ? I'm just waiting for some patches
from Heikki (in Cc) before we rip pdata from dwc3 completely. At that
point, we can look at building xhci from DT.

The only thing that comes to mind is how this will look for PCI-only
systems if we rip manual xHCI device creation completely.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBkFtAAoJEIaOsuA1yqRE+BUP/1TK2voER0Bx0dHngfvszWBi
Cu/OQRJNffECeafhKC6ChSlTWQxoCFTjtF7zA2MZ8tDDN5ZkEofwiVAUL0D7/98Q
ow4Oa2OpVo/pmWSTj7WKFuGUPr6eKk+KXDy5i0TFj4wBF9JR3dN72AWkvd9w5jzK
g8er0oft0YPKeZUJE2F9lRDv6BQEeo/BFVsUqHtGsU/7wOS1PBCIJb0CLQog7Npj
xm6LNh39dpp8zDXUulXDdIJkpgmOvcw+EHP61i494bzwS6mcET3VdkvZr2DbjvUm
Wq2O/P+z4+GxdwcLnXI53YPyIeeEjy22pLg8taIGMrhVM4+NMfN/4288Kvp8RVro
4zUoW4qhY/GlLJTte7tRy+zfqYNIVRUYyy6xuSk4U2os2Q16HPtfcAy4jT5SJCsx
LX37gaIJ5nhtFhP6DM3ATANqjGSWIMQTGMSF8B/9pWpc9NCtr38dhxOadyAsxr5J
MuGkbIavL/2nqOCoRx3zDewhKC+vpmcA5vpkc2O8qJIzgDCLMiAFGBa10xrCCQkB
Bw1i0Gl6KAwgoF2mH9ypGMscGcByj9As1TKjrNggIR/UVdoknpLM7ZmTCRPQkbgV
g4XDhIggandbzVgLsJC5iRPb8kehXg0mgzH8axOHx7dXjLhxbL8T4iyq3UNxVqax
hZBirNCsz0NnSGy/7Bq8
=RMgx
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
