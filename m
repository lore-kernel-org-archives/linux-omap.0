From: Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: dts: Add am335x-boneblack-wireless
Date: Tue, 3 Jan 2017 15:29:41 -0500
Message-ID: <2D5ABB5A-E332-4D77-89EA-9DBF9A2FECFB@gmail.com>
References: <20161227175837.28970-1-robertcnelson@gmail.com> <20161227175837.28970-2-robertcnelson@gmail.com> <CB5C8999-6CAE-41F6-85A6-D2A856BD8011@gmail.com> <20170103201103.GB25222@atomide.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170103201103.GB25222-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



> On Jan 3, 2017, at 3:11 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>=20
> * Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [161228 13:27]:
>>=20
>>=20
>>> On Dec 27, 2016, at 11:58 AM, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
>>>=20
>>> BeagleBone Black Wireless is clone of the BeagleBone Black (BBB) with th=
e Ethernet
>>> replaced by a TI wl1835 wireless module.
>>>=20
>>> This board can be indentified by the BWAx value after A335BNLT (BBB) in t=
he at24 eeprom:
>>> BWAx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 57 41 35  |.U3.A335BNLTBWA=
5|]
>>=20
>> I believe the correct statement is BWxx, but BWBx reserves the option to b=
e software incompatible in some way. My preference is to have it boot anyway=
, but I believe that is only dependent in the bootloader.=20
>=20
> So does this patch need updating for that?

No, it is bootloader controlled.=20

>=20
> Regards,
>=20
> Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
