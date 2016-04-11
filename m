From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 02/10] usb: dwc3: omap: Make the wrapper interrupt shared
Date: Mon, 11 Apr 2016 16:20:35 +0300
Message-ID: <87twj8mgd8.fsf@intel.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com> <1460374506-9779-3-git-send-email-rogerq@ti.com> <87h9f8ny14.fsf@intel.com> <570B9DB9.8050807@ti.com> <87zit0mhdy.fsf@intel.com> <570BA375.2040203@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570BA375.2040203-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> On 11/04/16 15:58, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-oma=
p.c
>>>>> index 22e9606..51ca098 100644
>>>>> --- a/drivers/usb/dwc3/dwc3-omap.c
>>>>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>>>>> @@ -274,19 +274,25 @@ static irqreturn_t dwc3_omap_interrupt(int irq,=
 void *_omap)
>>>>>  {
>>>>>  	struct dwc3_omap	*omap =3D _omap;
>>>>>  	u32			reg;
>>>>> +	int			ret =3D IRQ_NONE;
>>>>>=20=20
>>>>>  	reg =3D dwc3_omap_read_irqmisc_status(omap);
>>>>>=20=20
>>>>> +	if (reg)
>>>>> +		ret =3D IRQ_HANDLED;
>>>>
>>>> you can avoid the local variable by returning early here.
>>>
>>> How can we return early? we need to check irq0_status as well right?
>>=20
>> Oh, that's true.
>>=20
>> There's one thing that I noticed though. dma_status is only written to,
>> never read, so you should be able to remove it completely (a bit
>> off-topic, sorry).
>>=20
> I'll send a patch for that. Can it go in -rc as well along with the other=
 2?

probably not, as it's not fixing any bug ;-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC6SjAAoJEIaOsuA1yqREIJcQAI4xneqvdf6eKoefISlTnoBZ
HO7bVYsyF9WlIZhNQtWT5Fc19nXg3KZWx1EwLWmxSRNb1XWVruXp40+F6XSyNOBy
Ak0oM1K4xEHhc9jh1a9nWr8XypAbxz7/Vfsu3sW1QtG+hjmjbQCN/7g3Fp2j+6eC
Y2u52O/mWjeUhKwGvKbGCEy5d4yv/LCLYB67dMF0AKoCW265dxt6XlMBDZWiwv1T
wdUHiRm+VKG5GYGURW+abjwkimT6rRDhiagJRG+m5JheYMUYisoV2wCS7odOjHLu
7nzDHFj/UQ0Ng9kFcRu6YKam+RTltzCfbezMRRvKYyL0GtqkSvnFyAu08Z7B12OP
cAH9YvpH2Swr9Xn5bM8bebAGKJeyv2TL8uZndOi/7szv/McMhgzZBmM4RKVWwRg9
IBNBPayQWw6hE8nL9kRxkNKUaOdf1eRDONJr3US6Kv4Jf+DTwdgYhNfEmDmO6jbc
13F1wNSROCoTR0vlEqyeKMrzpHhuRSkSRCtJvlxHh7MUjYmwzlznHs+Or8c3E/RN
0bHHWZQiNb1OgHuyzvI8zlyI4Hs1DEPAbc2oIcDn9bnWQoJRAlFtmwKSNdZzftTD
5rUE7/yeBKw26Don+iJJDHw7LRBxwwOxgN+ARnibbettZRDyWbVmyzFaAgnxaqaJ
xIq8pYnhdCK70zkeOfrE
=Pn8O
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
