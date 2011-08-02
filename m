From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 03/13] PM: QoS: extend the in-kernel API with per-device
 latency constraints
Date: Tue, 2 Aug 2011 11:41:50 +0200
Message-ID: <CAORVsuVY63VYGEB7CM50UzJS3wLt+jZn5U6S9X+277GB_ETV1g@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-4-git-send-email-j-pihet@ti.com>
	<201107300055.49468.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40644 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab1HBJlv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 05:41:51 -0400
Received: by qyk9 with SMTP id 9so3777254qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 02:41:50 -0700 (PDT)
In-Reply-To: <201107300055.49468.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

Rafael,

2011/7/30 Rafael J. Wysocki <rjw@sisk.pl>:
> On Thursday, July 28, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Extend the PM QoS kernel API:
>> - add a new PM QoS class PM_QOS_DEV_LATENCY for device wake-up laten=
cy
>> constraints
>> - make the pm_qos_add_request API more generic by using a parameter =
of
>> type struct pm_qos_parameters
>> - minor clean-ups and rename of struct fields:
>> =A0 . rename pm_qos_class to class and pm_qos_req to req in internal=
 code
>> =A0 . consistenly use req and params as the API parameters
>> =A0 . rename struct pm_qos_request_list to struct pm_qos_request
>> - update the in-kernel API callers to the new API
>
> There should be more about the motivation in the changelog. =A0It say=
s
> what the patch is doing, but it doesn't say a word of _why_ it is don=
e in
> the first place.
Ok will add a comment

>
> Second, you're renaming a lot of things in the same patch that makes
> functional changes. =A0This is confusing and makes it very difficult =
to
> understand what's going on. =A0Please use separate patches to rename
> things, when possible, and avoid renaming things that don't need to b=
e
> renamed.
Sorry about that! I will split up the patches.

=2E..
>>
>> -struct pm_qos_request_list {
>> +struct pm_qos_request {
>
> This renaming should go in a separate patch, really.
Ok

>
>> =A0 =A0 =A0 struct plist_node list;
>> - =A0 =A0 int pm_qos_class;
>> + =A0 =A0 int class;
>
> This renaming doesn't seem to be necessary. =A0Moreover, it's confusi=
ng,
> because there already is struct class (for device classes) and a memb=
er
> called "class" in struct device and they aren't related to this one.
I will keep pm_qos_class if the rename brings in some confusion. The
intention was to simplify the names of the fields in structs with
explicit names.

>
>> + =A0 =A0 struct device *dev;
>> =A0};
>>
>> -void pm_qos_add_request(struct pm_qos_request_list *l, int pm_qos_c=
lass, s32 value);
>> -void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
>> - =A0 =A0 =A0 =A0 =A0 =A0 s32 new_value);
>> -void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
>> +struct pm_qos_parameters {
>> + =A0 =A0 int class;
>> + =A0 =A0 struct device *dev;
>> + =A0 =A0 s32 value;
>> +};
>
> What exactly is the "dev" member needed for?
This is the target device that is passed as parameter to the API. It
is used for constraints of the devices latency class.

=2E..
>> +static BLOCKING_NOTIFIER_HEAD(dev_lat_notifier);
>> +static struct pm_qos_object dev_pm_qos =3D {
>> + =A0 =A0 .requests =3D PLIST_HEAD_INIT(dev_pm_qos.requests, pm_qos_=
lock),
>> + =A0 =A0 .notifiers =3D &dev_lat_notifier,
>> + =A0 =A0 .name =3D "dev_latency",
>> + =A0 =A0 .target_value =3D PM_QOS_DEV_LAT_DEFAULT_VALUE,
>> + =A0 =A0 .default_value =3D PM_QOS_DEV_LAT_DEFAULT_VALUE,
>> + =A0 =A0 .type =3D PM_QOS_MIN,
>> +};
>> +
>
> You seem to be confusing things here. =A0Since devices will have thei=
r own lists
> of requests now (as per the previous patch), the .requests member abo=
ve is not
> necessary. =A0Moreover, it seems to be used incorrectly below.
The idea was to split the patches as requested previously: first the
API changes (this very patch [03/13]) and then the actual
implementation ([04/13]). Is this correct?

=2E..
>> -int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *no=
tifier)
>> +int pm_qos_add_notifier(int class, struct notifier_block *notifier)
>> =A0{
>> =A0 =A0 =A0 int retval;
>>
>> =A0 =A0 =A0 retval =3D blocking_notifier_chain_register(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_qos_array[pm_qos_class]=
->notifiers, notifier);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_qos_array[class]->notif=
iers, notifier);
>
> Now, there's a question if we want to have one notifier chain for all
> devices or if it's better to have a per-device notifier chain. =A0Bot=
h
> approaches have their own advantages and drawbacks, but in the latter
> case this code will have to be reworked.
I really think the need is for a per-class notifier. Cf. comments on
[04/13] about that.

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
