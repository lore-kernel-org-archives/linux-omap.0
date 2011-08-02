From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 05/13] PM: QoS: support the dynamic insertion and removal
 of devices
Date: Tue, 2 Aug 2011 12:07:38 +0200
Message-ID: <CAORVsuVrH-tL5S-yRMzauMRvpvEE9v1_ZMDDDdsHdJBGSZW+oA@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-6-git-send-email-j-pihet@ti.com>
	<201107310038.30710.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38770 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab1HBKHj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 06:07:39 -0400
Received: by qyk9 with SMTP id 9so3788841qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 03:07:38 -0700 (PDT)
In-Reply-To: <201107310038.30710.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

Rafael,

2011/7/31 Rafael J. Wysocki <rjw@sisk.pl>:
> On Thursday, July 28, 2011, jean.pihet@newoldbits.com wrote:
=2E..

>> @@ -113,6 +109,8 @@ void device_pm_remove(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 pr_debug("PM: Removing info for %s:%s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->bus ? dev->bus->name : "No Bus",=
 dev_name(dev));
>> + =A0 =A0 /* Call PM QoS to de-init the per-device latency constrain=
ts */
>> + =A0 =A0 pm_qos_dev_constraints_deinit(dev);
>
> I'd call this function "dev_pm_qos_constraints_destroy()" (and the pr=
evious
> one "dev_pm_qos_constraints_init()" for consistency).
Ok

=2E..
>> +/* Called from the device PM subsystem at device init */
>> +void pm_qos_dev_constraints_init(struct device *dev)
>> +{
>> + =A0 =A0 plist_head_init(&dev->power.latency_constraints.list, &dev=
->power.lock);
>> + =A0 =A0 dev->power.latency_constraints.target_value =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 PM_QOS_DEV_LAT_DEFAULT_VALUE;
>> + =A0 =A0 dev->power.latency_constraints.default_value =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 PM_QOS_DEV_LAT_DEFAULT_VALUE;
>> + =A0 =A0 dev->power.latency_constraints.type =3D PM_QOS_MIN;
>> + =A0 =A0 dev->power.latency_constraints_init =3D 1;
>
> You could avoid adding this field if there were a PM_QOS_UNINITIALIZE=
D
> (or PM_QOS_UNKNOWN) type.
>
> And if you _really_ want to have a separate field, why don't you put =
it
> into latency_constraints ?
Ok I remove latency_constraints_init and use the type field instead.

=2E..
>
> Thanks,
> Rafael

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
