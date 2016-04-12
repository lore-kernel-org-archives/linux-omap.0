From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 07/10] usb: dwc3: gadget: Fix suspend/resume during dual-role mode
Date: Tue, 12 Apr 2016 11:00:23 +0300
Message-ID: <87shyrl0iw.fsf@intel.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com> <1460374506-9779-8-git-send-email-rogerq@ti.com> <878u0knxkp.fsf@intel.com> <570BA2AA.8030308@ti.com> <87oa9gmg2k.fsf@intel.com> <570BAC4D.8010209@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570BAC4D.8010209-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> On 11/04/16 16:26, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>> On 11/04/16 15:23, Felipe Balbi wrote:
>>>>
>>>> Hi,
>>>>
>>>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>>> Gadget controller might not be always active during suspend/
>>>>> resume when we are operating in dual-role/otg mode.
>>>>> Check if we're active and only if we are then perform
>>>>> necessary actions during suspend/resume.
>>>>
>>>> I don't get this. If we're operating in OTG, we should have a gadget
>>>> driver loaded, no ?
>>>>
>>> At boot gadget driver is not automatically loaded. We're still in OTG m=
ode
>>> but OTG state machine hasn't started.
>>> System suspend/resume can still happen.
>>>
>>> User might also load/unload the gadget driver prior to system suspend.
>>=20
>> good point, this should go in the -rc too.
>>=20
> But there is no dual-role mode currently so it won't fix any bug yet :).

this should be a problem even for device-only, right ?

i) boot-up
ii) modprobe dwc3
iii) echo mem > /sys/power/state

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDKsYAAoJEIaOsuA1yqRE6M4P/j2sBryLB5qYW8JvrpF0zbZ9
t7OCSuiKp1/3x6aD6H8LUbKvVdcPvnn4jS7knpM2h6TBYTeN+QdEYkJ2ek76bsQN
Yy8044y/gq5mr6pzQx0zcarFStuDJPELUa5TkjRaVfokjMQIUG/oVJPPL7VlxaBp
33gZ4RDpRktPnoreb96ffZ6Gbh7dwE+Hi+pfTvXwybdnea01kXsK6iqn+Gwj7DQ5
txQfnCDrLQIq9l9B8c0QK3hT0hzn+iLJB1tlu/+znhuRXOsi6h8i0gPHCDBxPinr
DTP7MBI7cRJbVFlWoJCp71z2zu1sfvahqRJSdRU+aZR21IP8yKHE/aInHgrKxGZr
XGZ7cHL6iPy968BRkcuaRpoxd/LHTxjJnx97fyO+AwNVjFi40mEAomsskzhhzsrY
ja0hQg1iv+PyEAEiGSteP9hzdUkhKFz7yZTTyh9NBbXAgVNc0MsBzfTBF6A6pmal
xy/38oHGxMMfWgITWFhD3+9IbPnAMdbTy+9wezYLCdlwYgUL582hX573ziQYv8tC
HdY4UC/J2FXvoyIU/7QVmg82LR3CVM/+dthg90Hioh4VM2DpZ1AT70bJMw9fmstk
OgVMPC0UvsoTxecvvtoLr/QkDuuzrFn6QCuouJ6gyOu2++BRzJnc3vV5MyucaG0v
5IMkMcMF3O5fZylW+DcB
=Ln3c
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
