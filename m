From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Mon, 28 Jun 2010 16:47:49 -0700
Message-ID: <AANLkTimgPdrhpDKxd9YhficNddzLEbw_hxkM6_6rh4Wg@mail.gmail.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com> <AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
	<87fx06viuc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35195 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0F1XsL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 19:48:11 -0400
Received: by gxk23 with SMTP id 23so354257gxk.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Jun 2010 16:48:09 -0700 (PDT)
In-Reply-To: <87fx06viuc.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.miao@canonical.com>, Nicolas Pitre <nico@fluxnic.net>

On Mon, Jun 28, 2010 at 4:27 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>
> [...]
>
>>
>>> This affects many aspects of all drivers, from register and probe (=
for
>>> early devices/drivers too!) to all the plaform_get_resource() usage=
, all
>>> of which assumes a platform_driver and platform_device. =A0I didn't=
 look
>>> closely, but I didn't see if (or how) OF was handling early devices=
=2E
>>
>> You don't have to reimplement the entire platform bus. =A0You could
>> simply create a new bus type, but reuse all the existing platform bu=
s
>> code. =A0All that changes is the bus type that the device and the dr=
iver
>> gets registered on. =A0Then you could easily replace only the functi=
ons
>> that matter. =A0(do a git grep platform_bus_type to see how few
>> references there actually are. =A0It looks like there are only 5
>> references to it in drivers/base/platform.c that you'd need to work
>> around; in platform_device_add(), platform_driver_register(), 2 in
>> platform_driver_probe(), and the register in platform_bus_init(). =A0=
You
>> may not even need to reimplement platform_driver_probe().
>>
>> It might even be as simple as doing this:
>> - =A0 =A0 =A0 =A0pdev->dev.bus =3D &platform_bus_type;
>> + =A0 =A0 =A0 if (!pdev->dev.bus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdev->dev.bus =3D &platform_bus_typ=
e;
>>
>> So that a different bus type can be selected at device registration
>> time
>
> just FYI...
>
> as a quick proof of concept, I've done a quick hack just to prove to
> myself that I could use platform_devices on a custom bus, and it inde=
ed
> works. =A0The small patch below[1] shows the changes required to the
> platform code.
>
> Next step was to hack up minimal custom bus code. =A0The quickest (an=
d
> dirtiest) way was to simply memcpy platform_bus_type into my new
> omap_bus_type and then override the few dev_pm_ops functions I needed=
[2].
>
> So, with these in place, and using the dev_pm_ops functions from
> $SUBJECT patch, I was able register a platform_device and
> platform_driver onto my custom bus and see my custom dev_pm_ops
> functions being used as expected.

Nice!

> While admittedly a bit hacky, at least this paves the way in my head
> that this is indeed do-able, and I can take my vacation in peace with=
out
> this particular problem haunting me (too much.)

indeed.  It could be less hacky also by adding a
platform_bus_type_init() function to the common platform code.

Cheers,
g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
