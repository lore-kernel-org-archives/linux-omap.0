From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapdss: extend pm notifier to handle hibernation
Date: Fri, 20 Mar 2015 17:21:15 +0200
Message-ID: <550C3AEB.1090802@ti.com>
References: <1424883836-9119-1-git-send-email-grygorii.strashko@linaro.org> <550C108E.3020907@ti.com> <550C3545.8060702@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="wh6MqPi5ftN3vwKhJMjIp8MQxptEn5d1s"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48739 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbbCTPVY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 11:21:24 -0400
In-Reply-To: <550C3545.8060702@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, kishon@ti.com, linux-fbdev@vger.kernel.org

--wh6MqPi5ftN3vwKhJMjIp8MQxptEn5d1s
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/03/15 16:57, Grygorii.Strashko@linaro.org wrote:
> Hi Tomi,
>=20
> On 03/20/2015 02:20 PM, Tomi Valkeinen wrote:
>> On 25/02/15 19:03, grygorii.strashko@linaro.org wrote:
>>> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>>
>>> Add handling of missed events in omap_dss_pm_notif which are
>>> needed to support hibernation (suspend to disk).
>>>
>>> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>> ---
>>>   drivers/video/fbdev/omap2/dss/core.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/video/fbdev/omap2/dss/core.c b/drivers/video/fbd=
ev/omap2/dss/core.c
>>> index 6b74f73..e60976a 100644
>>> --- a/drivers/video/fbdev/omap2/dss/core.c
>>> +++ b/drivers/video/fbdev/omap2/dss/core.c
>>> @@ -178,11 +178,15 @@ static int omap_dss_pm_notif(struct notifier_bl=
ock *b, unsigned long v, void *d)
>>>   	DSSDBG("pm notif %lu\n", v);
>>>  =20
>>>   	switch (v) {
>>> +	case PM_HIBERNATION_PREPARE:
>>>   	case PM_SUSPEND_PREPARE:
>>> +	case PM_RESTORE_PREPARE:
>>>   		DSSDBG("suspending displays\n");
>>>   		return dss_suspend_all_devices();
>>>  =20
>>>   	case PM_POST_SUSPEND:
>>> +	case PM_POST_HIBERNATION:
>>> +	case PM_POST_RESTORE:
>>>   		DSSDBG("resuming displays\n");
>>>   		return dss_resume_all_devices();
>>>  =20
>>
>> Why suspend displays when PM_RESTORE_PREPARE happens? Why resume when
>> PM_POST_RESTORE happens?
>=20
> We have following sequence when system is restored from hibernation:
> - original kernel booted;
> - late_initcall_sync(software_resume);
>   - pm_notifier_call_chain(PM_RESTORE_PREPARE);
>   - freeze_processes
>   - check & read hibernation image
>   - suspend all devices (.freeze())
>   - jump to stored kernel
>   - restore devices
>   ...
>=20
> So, all devices should be in frozen/suspended state when we will jump t=
o stored kernel
> (device's state should be the same as before creating hib image).
>=20
> Without this patch I can see a lot of log messages like below:

Yes, I am sure a fix is needed for hibernation. But I still don't quite
understand PM_RESTORE_PREPARE and PM_POST_RESTORE.

When we enter hibernation, there's only PM_HIBERNATION_PREPARE?

When waking from hibernation, there's first PM_RESTORE_PREPARE, where we
need to disable displays that were enabled during boot. Then either
PM_POST_HIBERNATION if all went well, or PM_POST_RESTORE if there was an
error, and in both cases we want to enable the displays?

 Tomi



--wh6MqPi5ftN3vwKhJMjIp8MQxptEn5d1s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVDDrrAAoJEPo9qoy8lh71Y9IP/3MY65KIKCWnEq3J+6t7NknI
QB1D7pMO3MF5MMKMY95WD2mZxEqOr0X8aJGcugQp0snKDx7xGTE+6QrsIw2rn/9y
G0f5sVF4N2KUocU0YlFs+3E7SJQCwYuB/nnbBRhQHaqSsncXI801E+CuuSp9skrp
1WuFBFIj1/FREGMulYCTNJeFuJ3wiE3Y/U/+d8rpK/4jfOTuFpBp9Xtdg1Xxvyei
dNOuT3eSRzwWWv/+qJHJPsCzG7Aiz9Ae8zkcp4felKHBlv7iIz248kAi46Xw2X0G
JfhBi7v0/GmCwzmUWzk31lYsWbqQgJjh4h0GYdgpjdji1Flmb9rbVrRlOU+UJRnu
scEvC9A0jms86P4Giz6razXboh7AeBw4FkTneFcheYoTWrcVg8Oq72U6V/HtlcjU
1RsSIjfzb73XNfCS/5LxscGtVQobN3HS2WdexGdOLPcOpIwGdZZSksU3RYmyV0qV
ZrC1Cq8hJ+09VrHHX147wkzwy86EK/MOR/G5NY+4Qk2gYL1Iq2XdfJExGQ8Nx8OQ
1rceEA2aJeSs6SQ0WOTd0EELFS/SguRgBMdFCa/Nq6vw5/zZeqxmzekA1OwW9hE1
7Bp9+FmMInfnMzftTbLuSyK4WxjbL+UXbqjaRCIhhMePE+UTERsw3YXDauaWVTep
EPo4+Cv5PRQ3gg1EaI72
=pd1m
-----END PGP SIGNATURE-----

--wh6MqPi5ftN3vwKhJMjIp8MQxptEn5d1s--
