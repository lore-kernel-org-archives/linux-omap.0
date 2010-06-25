From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Fri, 25 Jun 2010 16:30:56 -0600
Message-ID: <AANLkTimcN6APawXLTzGIBUJ6DeGv8B0MEhbeJFkO59R-@mail.gmail.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com> <AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
	<87wrtmepum.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37691 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab0FYWbY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 18:31:24 -0400
Received: by iwn41 with SMTP id 41so2461854iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 15:31:23 -0700 (PDT)
In-Reply-To: <87wrtmepum.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.miao@canonical.com>, Nicolas Pitre <nico@fluxnic.net>

On Fri, Jun 25, 2010 at 3:58 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>> Yes, I've got patches which merge of_platform_bus_type with the
>> platform bus. =A0This was an easy decision to make because the
>> of-specific bits (specifically, matching an of_device_id table with =
a
>> device tree node) are applicable to all bus types; i2c, spi, mdio,
>> platform, etc). =A0The needed OF data structures have been moved int=
o
>> struct device and struct device_driver so that of_platform_bus_type =
no
>> longer has anything different.
>>
>> The drivers still need to care about OF when extra platform data nee=
ds
>> to be extracted from the DT node, but for IRQs and register ranges i=
t
>> is automatic.
>
> Does that mean the drivers are still doing platform_get_resource() fo=
r
> either platform devices or OF devices, or are does the driver have to
> know which bus it was on and call accordingly. =A0It's the latter tha=
t I
> want to stay away from.

platform_get_resource() works for OF and non-OF platform devices with
no extra code needed in the OF case.

It's the other data that requires special code because it is provided
in the device tree instead of in a platform_data structure.  A driver
that normally uses platform_data will need extra code early in the
probe hook to go and parse the device tree and populate the private
data structures accordingly.  This behaviour has to be handled in the
driver because every driver uses a different platform_data structure.
It cannot be generic code.  The rest of the driver can remain
untouched.

In the old (bad) way, the bus type was entirely different, and drivers
used by both platform_bus_type and of_platform_bus_type needed to have
entirely separate device_driver structures and probe() hooks for each
bus type.

[...]
>> So, instead of having all the platform_bus_type devices as children =
of
>> the "platform" device (/sys/devices/platform/*), you could set the
>> omap devices to be children of an omap bus device
>> (/sys/devices/omap/*). =A0Different busses can also implement differ=
ent
>> behaviour by using a different parent device. =A0For example:
>>
>> /sys/devices/platform
>> /sys/devices/omap-bus-a
>> /sys/devices/omap-bus-a/omap-bus-b
>>
>> Thoughts?
>
> Hmm, I like this idea. =A0This is certainly worth exploring as a firs=
t
> pass.
>
> Thanks for the idea,

:-)
g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
