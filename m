From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 25/26] OMAP: PM: convert the SmartReflex code into the AVS
 driver framework
Date: Wed, 23 Nov 2011 12:30:54 +0100
Message-ID: <CAORVsuUio6viQxBFJES0wm7sP3O44se0CsiXue95XEKiR5_F4w@mail.gmail.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
	<1321974370-25800-26-git-send-email-j-pihet@ti.com>
	<20111123095120.GD25068@legolas.emea.dhcp.ti.com>
	<CAORVsuV2bRJrCnk2Kntr3YgZzoTcFyVcg6A6ZSUUOqkh9Jz0uA@mail.gmail.com>
	<20111123110448.GP25068@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58394 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab1KWLa4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 06:30:56 -0500
Received: by vcbfk14 with SMTP id fk14so169372vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 03:30:55 -0800 (PST)
In-Reply-To: <20111123110448.GP25068@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>

=46elipe,

On Wed, Nov 23, 2011 at 12:04 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Nov 23, 2011 at 11:22:42AM +0100, Jean Pihet wrote:
>> Hi Felipe,
>>
>> On Wed, Nov 23, 2011 at 10:51 AM, Felipe Balbi <balbi@ti.com> wrote:
>> > On Tue, Nov 22, 2011 at 04:06:09PM +0100, jean.pihet@newoldbits.co=
m wrote:
>> >> +config POWER_AVS_OMAP_V1
>> >> + =A0 =A0 tristate "AVS support for the OMAP IP version 1"
>> >> + =A0 =A0 depends on ARCH_OMAP3 && PM
>> >> + =A0 =A0 help
>> >> + =A0 =A0 =A0 Say Y to enable AVS support on OMAP containing the =
version 1 of
>> >> + =A0 =A0 =A0 the SmartReflex IP.
>> >> + =A0 =A0 =A0 V1 is the 65nm version used in OMAP3430.
>> >> +
>> >> + =A0 =A0 =A0 Please note, that by default SmartReflex is only
>> >> + =A0 =A0 =A0 initialized. To enable the automatic voltage
>> >> + =A0 =A0 =A0 compensation for vdd mpu =A0and vdd core from user =
space,
>> >> + =A0 =A0 =A0 user must write 1 to
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /debug/voltage/vdd_<X>/smartreflex/auto=
comp,
>> >> + =A0 =A0 =A0 where X is mpu or core for OMAP3.
>> >> + =A0 =A0 =A0 Optionally autocompensation can be enabled in the k=
ernel
>> >> + =A0 =A0 =A0 by default during system init via the enable_on_ini=
t flag
>> >> + =A0 =A0 =A0 which an be passed as platform data to the smartref=
lex driver.
>> >> +
>> >> +config POWER_AVS_OMAP_V2
>> >> + =A0 =A0 tristate "AVS support for the OMAP IP version 2"
>> >> + =A0 =A0 depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM
>> >> + =A0 =A0 help
>> >> + =A0 =A0 =A0 Say Y to enable AVS support on OMAP containing the =
version 2 of
>> >> + =A0 =A0 =A0 the SmartReflex IP.
>> >> + =A0 =A0 =A0 V2 is the update for the 45nm version of the IP use=
d in OMAP3630
>> >> + =A0 =A0 =A0 and OMAP4430
>> >
>> > can't you read the revision register and decide this in runtime ?
>> Those Kconfig options are used to compile the v1 and/or v2 drivers.
>> The init of v1 or v2 is decided at runtime, cf. the sr_init function=
s
>> where the cpu revision is checked. Is this the correct check?
>
> if you already decide in runtime the correct initialization to call, =
why
> do you add ifdefs ?
There is no #ifdef with CONFIG_POWER_AVS_OMAP_V[12], those options are
used to compile or not the respective modules, cf.
driver/power/avs/Makefile.

> It's not like you're adding that huge amount of code
> for v1 and v2, right ?
That is correct, so both modules could be always compiled and init'ed
at runtime depending on the chip revision.

I am OK to change the code, please let me know what you think.

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
