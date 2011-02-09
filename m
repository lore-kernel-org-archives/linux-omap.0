From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v2 2/2] omap3: beaglexm: fix DVI initialization
Date: Wed, 9 Feb 2011 17:23:49 +0530
Message-ID: <AANLkTinJVYMYhM0HAPGoxz=782sn2+jE3CTq1sLDs3C6@mail.gmail.com>
References: <1297194235-7376-1-git-send-email-ricardo.salveti@canonical.com>
	<1297194235-7376-3-git-send-email-ricardo.salveti@canonical.com>
	<AANLkTin9VRwgMyw9LUr691n++QByq14JGdARwN3ZVqW0@mail.gmail.com>
	<1297252029.15396.4.camel@evatp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:57972 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753392Ab1BILxv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Feb 2011 06:53:51 -0500
Received: by mail-bw0-f50.google.com with SMTP id 12so905884bwg.23
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 03:53:50 -0800 (PST)
In-Reply-To: <1297252029.15396.4.camel@evatp>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Cc: linux-omap@vger.kernel.org, charu@ti.com

On Wed, Feb 9, 2011 at 5:17 PM, Ricardo Salveti de Araujo
<ricardo.salveti@canonical.com> wrote:
> On Wed, 2011-02-09 at 12:23 +0530, G, Manjunath Kondaiah wrote:
>> On Wed, Feb 9, 2011 at 1:13 AM, Ricardo Salveti de Araujo
>> <ricardo.salveti@canonical.com> wrote:
>> > Function beagle_twl_gpio_setup is called after beagle_display_init=
, what
>> > lets reset_gpio with an invalid value at the time it request the g=
pio.
>> > As a side effect the DVI reset GPIO is not properly set.
>> >
>> > Also removing old code that powers down DVI in a hardcoded way, as=
 it's
>> > not necessary anymore.
>> >
>> > Tested with Beagle-xM and C4.
>>
>> Surprised to see if this code works on C4 since there is gpio_reques=
t
>> for gpio_170 in the beagle init code
>> (linux omap master branch) which is before beagle_display_init()
>>
>> =A0 =A0 =A0 =A0 omap_mux_init_gpio(170, OMAP_PIN_INPUT);
>> =A0 =A0 =A0 =A0 gpio_request(170, "DVI_nPD");
>> =A0 =A0 =A0 =A0 /* REVISIT leave DVI powered down until it's needed =
=2E.. */
>> =A0 =A0 =A0 =A0 gpio_direction_output(170, true);
>>
>> The second gpio_request(for 170) should fail in beagle_display_init.
>> Pls check and confirm.
>
> That's why this part is also removed at my patch.

Thanks. Changes looks fine.

Reviewed-by: Manjunath G Kondaiah <manjugk@ti.com>

-Manjunath
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
