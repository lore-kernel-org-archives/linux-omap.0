From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 09/22] OMAP2: add voltage domains and connect to powerdomains
Date: Fri, 09 Sep 2011 14:46:03 -0700
Message-ID: <877h5htmn8.fsf@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-10-git-send-email-khilman@ti.com>
	<CAORVsuXd2eeSs_TFu+stJge6tqQzO+4d0FcnmDPMHnChLgCuiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:52616 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751795Ab1IIVqG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Sep 2011 17:46:06 -0400
Received: by mail-pz0-f49.google.com with SMTP id 6so4069865pzk.8
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 14:46:05 -0700 (PDT)
In-Reply-To: <CAORVsuXd2eeSs_TFu+stJge6tqQzO+4d0FcnmDPMHnChLgCuiQ@mail.gmail.com>
	(Jean Pihet's message of "Wed, 7 Sep 2011 12:39:36 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Kevin,
>
> On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Create basic voltagedomains for OMAP2 and associate OMAP2 powerdomai=
ns
>> with the newly created voltage domains.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A03 +-
>> =C2=A0arch/arm/mach-omap2/io.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +
>> =C2=A0arch/arm/mach-omap2/powerdomains2xxx_data.c =C2=A0 | =C2=A0 =C2=
=A04 +++
>> =C2=A0arch/arm/mach-omap2/voltage.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> =C2=A0arch/arm/mach-omap2/voltagedomains2xxx_data.c | =C2=A0 32 ++++=
+++++++++++++++++++++
>> =C2=A05 files changed, 41 insertions(+), 1 deletions(-)
>> =C2=A0create mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data=
=2Ec
>>
> ...
>
>> diff --git a/arch/arm/mach-omap2/voltagedomains2xxx_data.c b/arch/ar=
m/mach-omap2/voltagedomains2xxx_data.c
>> new file mode 100644
>> index 0000000..69ff261
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
>> @@ -0,0 +1,32 @@
>> +/*
>> + * OMAP3 voltage domain data
>> + *
>> + * Copyright (C) 2007, 2010 Texas Instruments, Inc.
> 2011?
>

Thanks, will update.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
