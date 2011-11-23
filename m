From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 25/26] OMAP: PM: convert the SmartReflex code into the AVS
 driver framework
Date: Wed, 23 Nov 2011 11:22:42 +0100
Message-ID: <CAORVsuV2bRJrCnk2Kntr3YgZzoTcFyVcg6A6ZSUUOqkh9Jz0uA@mail.gmail.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
	<1321974370-25800-26-git-send-email-j-pihet@ti.com>
	<20111123095120.GD25068@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62426 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab1KWKWn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 05:22:43 -0500
Received: by vcbfk14 with SMTP id fk14so105904vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 02:22:43 -0800 (PST)
In-Reply-To: <20111123095120.GD25068@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>

Hi Felipe,

On Wed, Nov 23, 2011 at 10:51 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Nov 22, 2011 at 04:06:09PM +0100, jean.pihet@newoldbits.com w=
rote:
>> +config POWER_AVS_OMAP_V1
>> + =A0 =A0 tristate "AVS support for the OMAP IP version 1"
>> + =A0 =A0 depends on ARCH_OMAP3 && PM
>> + =A0 =A0 help
>> + =A0 =A0 =A0 Say Y to enable AVS support on OMAP containing the ver=
sion 1 of
>> + =A0 =A0 =A0 the SmartReflex IP.
>> + =A0 =A0 =A0 V1 is the 65nm version used in OMAP3430.
>> +
>> + =A0 =A0 =A0 Please note, that by default SmartReflex is only
>> + =A0 =A0 =A0 initialized. To enable the automatic voltage
>> + =A0 =A0 =A0 compensation for vdd mpu =A0and vdd core from user spa=
ce,
>> + =A0 =A0 =A0 user must write 1 to
>> + =A0 =A0 =A0 =A0 =A0 =A0 /debug/voltage/vdd_<X>/smartreflex/autocom=
p,
>> + =A0 =A0 =A0 where X is mpu or core for OMAP3.
>> + =A0 =A0 =A0 Optionally autocompensation can be enabled in the kern=
el
>> + =A0 =A0 =A0 by default during system init via the enable_on_init f=
lag
>> + =A0 =A0 =A0 which an be passed as platform data to the smartreflex=
 driver.
>> +
>> +config POWER_AVS_OMAP_V2
>> + =A0 =A0 tristate "AVS support for the OMAP IP version 2"
>> + =A0 =A0 depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM
>> + =A0 =A0 help
>> + =A0 =A0 =A0 Say Y to enable AVS support on OMAP containing the ver=
sion 2 of
>> + =A0 =A0 =A0 the SmartReflex IP.
>> + =A0 =A0 =A0 V2 is the update for the 45nm version of the IP used i=
n OMAP3630
>> + =A0 =A0 =A0 and OMAP4430
>
> can't you read the revision register and decide this in runtime ?
Those Kconfig options are used to compile the v1 and/or v2 drivers.
The init of v1 or v2 is decided at runtime, cf. the sr_init functions
where the cpu revision is checked. Is this the correct check?

>
> --
> balbi
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
