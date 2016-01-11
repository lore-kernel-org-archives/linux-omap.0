From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: Nokia N900: u-SD card in v4.2+
Date: Mon, 11 Jan 2016 14:10:23 +0530
Message-ID: <56936A77.9070803@ti.com>
References: <20160106204627.GA21477@amd> <568DFA4B.7030308@ti.com>
 <20160107113408.GA26618@amd> <201601092344.44641@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201601092344.44641@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, tony@atomide.com
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Sunday 10 January 2016 04:14 AM, Pali Roh=C3=A1r wrote:
> On Thursday 07 January 2016 12:34:09 Pavel Machek wrote:
>> Hi!
>>
>>> On Thursday 07 January 2016 02:16 AM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>> In v4.1, both internal MMC and u-SD cards work ok.
>>>>
>>>> In v4.2, only the internal MMC is detected. In v4.3, not even
>>>> internal MMC works. In v4.4, only the internal MMC is detected.
>>>>
>>>> Does it work for you? Any patches?
>>>
>>> I don't have Nokia N900 to check this, but can you share your
>>> config and kernel logs? Check if CONFIG_REGULATOR_PBIAS is present
>>> in your config. CONFIG_REGULATOR_PBIAS is now mandatory for all
>>> omap3+ SoCs to work.
>>
>> I enabled CONFIG_REGULATOR_PBIAS and both MMCs now work.
>>
>> I wonder if we should add some selects, so that users updating from
>> old kernels don't break their system?
>=20
> Please add these selects. I had CONFIG_REGULATOR_PBIAS disabled too,=20
> because I just updated defconfig from older kernel version.

'select' is generally not recommended since it selects a config without
caring for the dependency. With adding 'depends on', MMC won't be enabl=
ed and
will end up in the same problem.

Tony has already added a Documentation noting that CONFIG_REGULATOR_PBI=
AS
should be enabled for MMCs to work.
commit d8e1f5ed11a39a68da00f05000466c4f6db4456e
Author: Tony Lindgren <tony@atomide.com>
Date:   Mon Oct 12 16:19:54 2015 -0700

    Documentation: ARM: List new omap MMC requirements

Maybe we should also make the error message a little more verbose to te=
ll the
user that CONFIG_REGULATOR_PBIAS be selected?

Thanks
Kishon
