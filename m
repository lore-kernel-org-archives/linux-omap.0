From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: dwc3 gadget breaks on system suspend/resume
Date: Tue, 31 Jan 2017 14:03:26 +0200
Message-ID: <87mve74esx.fsf@linux.intel.com>
References: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com> <87a8anjm5z.fsf@linux.intel.com> <a0cc2705-b1f5-7b6e-d73c-ff9b525eead2@ti.com> <e64bc4ee-1c71-d72c-cdc7-f5857f49a90e@ti.com> <87inp07fkx.fsf@linux.intel.com> <57fbf2b6-3811-3202-0e69-7cf82662d50f@ti.com> <8760l07dfh.fsf@linux.intel.com> <87wpdg5wtx.fsf@linux.intel.com> <a91c7564-5bfa-c77f-8fa2-1c1b0bcfd815@ti.com> <87o9yo66w7.fsf@linux.intel.com> <19de4c77-0e95-f7b5-0f56-a705134fd4cc@ti.com> <87inow662n.fsf@linux.intel.com> <87d1f464mp.fsf@linux.intel.com> <90f70eb2-8b87-d33e-71cd-335c05c6f65a@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <90f70eb2-8b87-d33e-71cd-335c05c6f65a-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>>>>> -DALEPENA =3D 0x0000000f
>>>>>>> +DALEPENA =3D 0x00000000
>>>>>>
>>>>>> Thanks for the hints.
>>>>>>
>>>>>> This problem is because reason dwc3_gadget_run_stop() is timing out
>>>>>> during the suspend sequence and so dwc3_disconnect_gadget() and
>>>>>> __dwc3_gadget_stop() are not being called.
>>>>>
>>>>> I see
>>>>>
>>>>>> dwc3_suspend() does not consider dwc3_gadget_suspend()'s return value
>>>>>> and happily continues suspending the machine.
>>>>>>
>>>>>> If I force dwc3_gadget_run_stop() to return 0 then everything works =
fine.
>>>>>>
>>>>>> Any ideas why DWC3_DSTS_DEVCTRLHLT is not getting set?
>>>>>
>>>>> no idea. It should always get set when run_stop is cleared. Can you
>>>>> check if suspending with cable detached has any difference?
>>>>
>>>> After cable detach, it still timed out the next suspend. But on
>>>> subsequent suspends there were no timeouts. (I didn't plug the cable
>>>> back at all)
>>>>
>>>> This behaviour is on dra7. I will test the behaviour on am43x as well.
>>>
>>> wonder if there's something odd with 2.02a. AM437x is 2.40a IIRC,
>>> testing that is, indeed, a good idea.
>
> Tried on am437x which is 2.40a but same timeout problem there as well.
>
>>=20
>> What if your platform just takes longer to halt?
>>=20
>> Can you try below?
>>=20
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 4db97ecae885..d2e405793b1f 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1586,7 +1586,7 @@ static int dwc3_gadget_set_selfpowered(struct usb_=
gadget *g,
>>  static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspen=
d)
>>  {
>>         u32                     reg;
>> -       u32                     timeout =3D 500;
>> +       u32                     timeout =3D 500000;
>>=20=20
>>         if (pm_runtime_suspended(dwc->dev))
>>                 return 0;
>>=20
>>=20
>
> Tried this but it doesn't resolve the issue.

Interesting. I have no idea what to try now. How about checking if that
susphy quirk flags help? Maybe your platform can't accept PHY being
suspended, or something.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAliQfQ4ACgkQzL64meEa
mQbH6RAAqJMlXJDDCYd2gE5yjF6MticdT067z71iTeeOcLctlUvvK7hLJn1Yfots
8t85w6Q+L2o97uei3OqPHYhg3yispg028A8ngsOPckydfLz/U19iBMk1a1bg94aB
s3x9WsN9pFzZYIzFfKkjxk9Hs3McN5F90IQhTfzGaeCGCHZehZ8Fg3r/qpHkc7tY
Wo/rHhF+awhiHrFX2Y7sG1y6XyEEFGSyHWqkmb0yGxYAiJr1x/WVgGuxo4PfDHyX
W7SMqoJqZPBOa/N3VqSc4FMWpDMt/+q1htD+MHKACFYl8QHaTMBTUqTbFP2hKcAP
2YGEPh4j+/xip4eq9tKVxtYidDET8g06RIk/VcwdrDpVSyLfPRpxB6ft/fHOsCws
UArHkexZ0n/7fDoRFSC4/JBqDYjQO91js8YKVeyZ0pMtzWbt9hL/6oQtSQ8uf1hm
4vnceomvmAnR5nZ/UpAbR23qmwXXT1trdGEou7cA7XVX/aPmI6gsnuyGpRlSWn/8
vAvYE2ZOxMyCcYWoqGyaoEjdaFNJECCfNeNLiLLgH3KKZpMEPuVO+wbzrxf2gxrG
wtyIuLQKBiexvwmO5MvA8Xj6FzwEqbvFXQKONQiRQDFwmki/RGlXR2HveFfW/mdx
dkvkeq2yYq/HO/hpl7zGlJIRar36QkI/5Ue2XMdsH/aeYarxPlk=
=8cVq
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
