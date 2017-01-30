From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: dwc3 gadget breaks on system suspend/resume
Date: Mon, 30 Jan 2017 15:47:58 +0200
Message-ID: <87d1f464mp.fsf@linux.intel.com>
References: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com> <87a8anjm5z.fsf@linux.intel.com> <a0cc2705-b1f5-7b6e-d73c-ff9b525eead2@ti.com> <e64bc4ee-1c71-d72c-cdc7-f5857f49a90e@ti.com> <87inp07fkx.fsf@linux.intel.com> <57fbf2b6-3811-3202-0e69-7cf82662d50f@ti.com> <8760l07dfh.fsf@linux.intel.com> <87wpdg5wtx.fsf@linux.intel.com> <a91c7564-5bfa-c77f-8fa2-1c1b0bcfd815@ti.com> <87o9yo66w7.fsf@linux.intel.com> <19de4c77-0e95-f7b5-0f56-a705134fd4cc@ti.com> <87inow662n.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87inow662n.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>>> (hmm, I didn't receive your reply in my intel inbox, only
>>>>> gmail. Odd. Replying to myself here, but it should be on your reply,
>>>>> rater).
>>>>>
>>>>> Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:
>>>>>>> The previous commit c499ff71ff2a281366c6ec7a904c547d806cbcd1 is fin=
e.
>>>>>>
>>>>>> okay. Then let's try to figure out what's going on. A diff of regdump
>>>>>> before and after suspend/resume might start to give some clue about
>>>>>> what's going on. DWC3 tracepoints should help too. Care to get those?
>>>>>> BTW, is this dwc3 as host or peripheral?
>>>>>
>>>>> You don't have any endpoints enabled:
>>>>>
>>>>> -DALEPENA =3D 0x0000000f
>>>>> +DALEPENA =3D 0x00000000
>>>>
>>>> Thanks for the hints.
>>>>
>>>> This problem is because reason dwc3_gadget_run_stop() is timing out
>>>> during the suspend sequence and so dwc3_disconnect_gadget() and
>>>> __dwc3_gadget_stop() are not being called.
>>>=20
>>> I see
>>>=20
>>>> dwc3_suspend() does not consider dwc3_gadget_suspend()'s return value
>>>> and happily continues suspending the machine.
>>>>
>>>> If I force dwc3_gadget_run_stop() to return 0 then everything works fi=
ne.
>>>>
>>>> Any ideas why DWC3_DSTS_DEVCTRLHLT is not getting set?
>>>=20
>>> no idea. It should always get set when run_stop is cleared. Can you
>>> check if suspending with cable detached has any difference?
>>
>> After cable detach, it still timed out the next suspend. But on
>> subsequent suspends there were no timeouts. (I didn't plug the cable
>> back at all)
>>
>> This behaviour is on dra7. I will test the behaviour on am43x as well.
>
> wonder if there's something odd with 2.02a. AM437x is 2.40a IIRC,
> testing that is, indeed, a good idea.

What if your platform just takes longer to halt?

Can you try below?

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4db97ecae885..d2e405793b1f 100644
=2D-- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1586,7 +1586,7 @@ static int dwc3_gadget_set_selfpowered(struct usb_gad=
get *g,
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
        u32                     reg;
=2D       u32                     timeout =3D 500;
+       u32                     timeout =3D 500000;
=20
        if (pm_runtime_suspended(dwc->dev))
                return 0;


=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAliPRA8ACgkQzL64meEa
mQZ4QBAAgsMRXfY6QkFOf8pBWpzgy2xs0aZPCrzW1NRx/pHdRnHSkSc636eX5pHf
ZHPozBMNlS5zAjmKAPo5qFjfAkf6Ds7aTavFZGtYX1wcQRjFhdCMVVkG732xQA8C
pCAVrtQ1zoOKgIXZ3Mw/mDE3z1QStHr9N0qjGZ2/Y9QsGb24o5XUdajScUnGKpBg
oIT0eR2z9qBCTHjMRP+5/zU+7NIBaE+GmUIzQsjgybs2w34l5zrbfDfSkpe7WURc
piVoRfi/mM8UBoYCrEOMKD4EeIWGUVQ1mG0pD0ube6WAyBQudG/SNIeeiYxRzdbR
tu0zkHC8CGCCYh9C+NlobCrXgMpMWTImiPIkuw6g5XgJ8bdHJRGE7+RBU4iubSLi
GbjJF5AA0wnyx7kUOzK35t6nvUROIXmd4qZ5Ehi01s+H4AawzclYSwMCcikNLi+F
r17VIA57sSpAnUsyXp39D39ZlbwxDBniHvCsqTfyssY2+5qk2wi1dHHYpuojQSZS
LNl85A/Ue+9zh/Bo7JQmyDOMJYvWFlVS4hF8K+vEG3TNxyj4bHuVpL3ZpsEJ9hm+
3Wy6IeZ0wNvPH+5duLbK6ABgJA/C1gnxv5VxgulcTQjTC/5sGWSwBsu1R2ufY12P
TXRTyIGHQtoPZLMfX/fmxS2w5UCEATUhmErg5UMvBgk96pr4y2I=
=RBHQ
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
