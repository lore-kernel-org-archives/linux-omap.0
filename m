From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Fri, 27 Nov 2015 09:52:05 +0100
Message-ID: <CAOf5uw==sROkdOU-mEEE2iqBECkX5XcqY_2kNxc1ZJFW+j7niw@mail.gmail.com>
References: <20150713131902.GH26485@atomide.com>
	<20151123144545.GD24147@pali>
	<20151125181644.GI2517@atomide.com>
	<17134653.86P3dFyQKK@wuerfel>
	<20151125210310.GT2517@atomide.com>
	<56568849.5080103@gmail.com>
	<20151126090739.GD14190@pali>
	<20151126203930.GW2517@atomide.com>
	<20151127083833.GA430@pali>
	<CAOf5uwn_3gY=xE8gBS2hZ-O4ZBZruxYRN8a_hO0bqCHy-yA2Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOf5uwn_3gY=xE8gBS2hZ-O4ZBZruxYRN8a_hO0bqCHy-yA2Gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Frank Rowand <frowand.list@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi

On Fri, Nov 27, 2015 at 9:44 AM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi
>
> On Fri, Nov 27, 2015 at 9:38 AM, Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
>> On Thursday 26 November 2015 12:39:30 Tony Lindgren wrote:
>>> Just to explore options.. How about make a minimal device driver th=
at
>>> just loads the atags blob from /lib/firmware and then shows it in
>>> /proc/atags? Of course some checking on the atags should be done by
>>> the driver..
>>
>> And who can dynamically create that blob file in /lib/firmware? If
>> kernel does not export those atags (somehow) from bootloader, then
>> userspace is not able to create that blob... cyclic problem.
>>
>
> Are those atags from bootloader fix or they change device by device. =
If they
> are fixed they can be included in some firmware and get from the disk=
=2E
>

Sorry, miss the second part of email ;)

Michael

> Michael
>
>> So no, problem is that bootloader provides via custom atags dynamic
>> information like: boot reason (how was device started, by rtc alarm?=
 by
>> reboot? by usb charger? by power button?), boot mode (should be ente=
r
>> into firmware update mode?, is this normal boot mode?), ... and thos=
e
>> information are needed for some proprietary software (e.g. firmware
>> upgrade/flash) but also by any other open source applications (based=
 on
>> usb charger we enter different runlevel -- for just only charging
>> device).
>>
>> --
>> Pali Roh=C3=A1r
>> pali.rohar@gmail.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
| Michael Nazzareno Trimarchi                     Amarula Solutions BV =
|
| COO  -  Founder                                      Cruquiuskade 47 =
|
| +31(0)851119172                                 Amsterdam 1018 AM NL =
|
|                  [`as] http://www.amarulasolutions.com               =
|
