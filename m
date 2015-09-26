From: Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] ARM: dts: twl4030: Add iio properties for bci subnode
Date: Sat, 26 Sep 2015 21:58:15 +0200
Message-ID: <CAAfyv36nZ3c-yw7QQHwBWk3GwY31rV3Uq2n0dz5hppn5JFhEcA@mail.gmail.com>
References: <1443212447-5841-1-git-send-email-marek@goldelico.com>
	<1443212447-5841-3-git-send-email-marek@goldelico.com>
	<20150926172936.GD22315@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150926172936.GD22315@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux PM mailing list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony sorry I forgot to add you to the recipients for this patchset.
Can you please queue this patch. Many thanks.

@Sebastian: thanks for noticing

On Sat, Sep 26, 2015 at 7:29 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wro=
te:
> Hi Marek,
>
> On Fri, Sep 25, 2015 at 10:20:47PM +0200, Marek Belisko wrote:
>> Added new iio properties which are required for twl4030-charger driv=
er and
>> allow to use twl4030-madc indirectly.
>>
>> Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/twl4030.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4=
030.dtsi
>> index 36ae916..482b7aa 100644
>> --- a/arch/arm/boot/dts/twl4030.dtsi
>> +++ b/arch/arm/boot/dts/twl4030.dtsi
>> @@ -22,6 +22,8 @@
>>       charger: bci {
>>               compatible =3D "ti,twl4030-bci";
>>               interrupts =3D <9>, <2>;
>> +             io-channels =3D <&twl4030_madc 11>;
>> +             io-channel-name =3D "vac";
>>               bci3v1-supply =3D <&vusb3v1>;
>>       };
>
> Acked-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> This patch is missing correct To/Cc:
>
> $ grep -A5 "OMAP DEVICE TREE SUPPORT" MAINTAINERS
> OMAP DEVICE TREE SUPPORT
> M:      Beno=C3=AEt Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> M:      Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> L:      linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> L:      devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> S:      Maintained
>
> -- Sebastian

BR,

marek

--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
