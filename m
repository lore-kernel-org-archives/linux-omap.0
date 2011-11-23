From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/6] OMAP: PM: register to the per-device PM QoS framework
Date: Wed, 23 Nov 2011 11:42:50 -0800
Message-ID: <87hb1ubp6t.fsf@ti.com>
References: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
	<1319032263-22699-4-git-send-email-j-pihet@ti.com>
	<87d3cq30ja.fsf@ti.com>
	<CAORVsuURENRLO-FAhau-eS2VmfZrG=BOgih_SPHUSD3Nv3j96w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:46318 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753801Ab1KWTmz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 14:42:55 -0500
Received: by mail-gy0-f181.google.com with SMTP id r13so2289387ghr.26
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 11:42:54 -0800 (PST)
In-Reply-To: <CAORVsuURENRLO-FAhau-eS2VmfZrG=BOgih_SPHUSD3Nv3j96w@mail.gmail.com>
	(Jean Pihet's message of "Tue, 22 Nov 2011 20:52:51 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Thu, Nov 17, 2011 at 10:24 PM, Kevin Hilman <khilman@ti.com> wrote=
:
>> jean.pihet@newoldbits.com writes:
>>
>>> From: Jean Pihet <j-pihet@ti.com>
>>>
>>> Implement the devices wake-up latency constraints using the global
>>> device PM QoS notification handler which applies the constraints to=
 the
>>> underlying layer by calling the corresponding function at hwmod lev=
el.
>>>
>>> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using w=
ake-up
>>> latency constraints on MPU, CORE and PER.
>>>
>>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ...
>
>>> +/* Interface to the per-device PM QoS framework */
>>> +static int omap2_dev_pm_qos_handler(struct notifier_block *nb,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long new_value,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *req)
>>> +{
>>> + =C2=A0 =C2=A0 struct omap_device *od;
>>> + =C2=A0 =C2=A0 struct omap_hwmod *oh;
>>> + =C2=A0 =C2=A0 struct platform_device *pdev;
>>> + =C2=A0 =C2=A0 struct dev_pm_qos_request *dev_pm_qos_req =3D req;
>>> +
>>> + =C2=A0 =C2=A0 pr_debug("OMAP PM CONSTRAINTS: req@0x%p, new_value=3D=
%lu\n",
>>
>> s/CONSTRAINTS/constraints/
>> another one below.
> Ok
>
>>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req, new_value);
>>> +
>>> + =C2=A0 =C2=A0 /* Look for the platform device for the constraint =
target device */
>>> + =C2=A0 =C2=A0 pdev =3D to_platform_device(dev_pm_qos_req->dev);
>>> +
>>> + =C2=A0 =C2=A0 /* Try to catch non platform devices */
>>
>> why?
> The constraints targets are the power domains, which you find by
> walking through the chain of structs dev, pdev, omap_device, hwmod an=
d
> finally pwrdm.

OK

>>
>>> + =C2=A0 =C2=A0 if (pdev->name =3D=3D NULL) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("%s: Error: plat=
form device for device %s not valid\n",
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__func__, dev_name(dev_pm_qos_req->dev));
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>>> + =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 /* Find the associated omap_device for dev */
>>> + =C2=A0 =C2=A0 od =3D container_of(pdev, struct omap_device, pdev)=
;
>>
>> What about devices that are valid platform_devices, but not omap_dev=
ices?
> Do you mean that od should be tested for NULL value?

=46irst, it should be using the to_omap_device() helper function from
omap_device.h.

Until v3.2, it was based on container_of() so checking for NULL will no=
t
help.  However, as of v3.2, because I decoupled platform_device and
omap_device, checking for a NULL return from to_omap_device() will be a
good enough check.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
