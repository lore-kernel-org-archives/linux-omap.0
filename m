From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 3/6] OMAP: PM: register to the per-device PM QoS framework
Date: Tue, 22 Nov 2011 20:52:51 +0100
Message-ID: <CAORVsuURENRLO-FAhau-eS2VmfZrG=BOgih_SPHUSD3Nv3j96w@mail.gmail.com>
References: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
	<1319032263-22699-4-git-send-email-j-pihet@ti.com>
	<87d3cq30ja.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37664 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab1KVTww convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 14:52:52 -0500
Received: by vbbfc21 with SMTP id fc21so589639vbb.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 11:52:51 -0800 (PST)
In-Reply-To: <87d3cq30ja.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Thu, Nov 17, 2011 at 10:24 PM, Kevin Hilman <khilman@ti.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Implement the devices wake-up latency constraints using the global
>> device PM QoS notification handler which applies the constraints to =
the
>> underlying layer by calling the corresponding function at hwmod leve=
l.
>>
>> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wa=
ke-up
>> latency constraints on MPU, CORE and PER.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
=2E..

>> +/* Interface to the per-device PM QoS framework */
>> +static int omap2_dev_pm_qos_handler(struct notifier_block *nb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 un=
signed long new_value,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vo=
id *req)
>> +{
>> + =A0 =A0 struct omap_device *od;
>> + =A0 =A0 struct omap_hwmod *oh;
>> + =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 struct dev_pm_qos_request *dev_pm_qos_req =3D req;
>> +
>> + =A0 =A0 pr_debug("OMAP PM CONSTRAINTS: req@0x%p, new_value=3D%lu\n=
",
>
> s/CONSTRAINTS/constraints/
> another one below.
Ok

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0req, new_value);
>> +
>> + =A0 =A0 /* Look for the platform device for the constraint target =
device */
>> + =A0 =A0 pdev =3D to_platform_device(dev_pm_qos_req->dev);
>> +
>> + =A0 =A0 /* Try to catch non platform devices */
>
> why?
The constraints targets are the power domains, which you find by
walking through the chain of structs dev, pdev, omap_device, hwmod and
finally pwrdm.

>
>> + =A0 =A0 if (pdev->name =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: platform device for dev=
ice %s not valid\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, dev_name(dev_pm_q=
os_req->dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Find the associated omap_device for dev */
>> + =A0 =A0 od =3D container_of(pdev, struct omap_device, pdev);
>
> What about devices that are valid platform_devices, but not omap_devi=
ces?
Do you mean that od should be tested for NULL value?

>
>> + =A0 =A0 if (od->hwmods_cnt !=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: No unique hwmod for dev=
ice %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, dev_name(dev_pm_q=
os_req->dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Find the primary omap_hwmod for dev */
>> + =A0 =A0 oh =3D od->hwmods[0];
>> +
>> + =A0 =A0 pr_debug("OMAP PM CONSTRAINTS: req@0x%p, dev=3D0x%p, new_v=
alue=3D%lu\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0req, dev_pm_qos_req->dev, new_value);
>> +
>> + =A0 =A0 /* Apply the constraint */
>> + =A0 =A0 return omap_hwmod_set_wkup_lat_constraint(oh, dev_pm_qos_r=
eq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 new_value);
>> +}
>> +
>> +static struct notifier_block omap2_dev_pm_qos_notifier =3D {
>> + =A0 =A0 .notifier_call =A0=3D omap2_dev_pm_qos_handler,
>> +};
>> +
>> +static int __init omap2_dev_pm_qos_init(void)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D dev_pm_qos_add_global_notifier(&omap2_dev_pm_qos_n=
otifier);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "Cannot add global notifi=
er for dev PM QoS\n");
>
> minor: could use WARN_ON()
Ok

>
>> + =A0 =A0 return ret;
>> +}
>> +
>> =A0static int __init omap2_common_pm_init(void)
>> =A0{
>> =A0 =A0 =A0 omap2_init_processor_devices();
>> =A0 =A0 =A0 omap_pm_if_init();
>>
>> + =A0 =A0 /* Register to the per-device PM QoS framework */
>> + =A0 =A0 omap2_dev_pm_qos_init();
>> +
>> =A0 =A0 =A0 return 0;
>> =A0}
>> =A0postcore_initcall(omap2_common_pm_init);
>
> Kevin
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
