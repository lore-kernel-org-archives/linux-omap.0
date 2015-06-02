From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 5/6] phy: twl4030-usb: add support for reading resistor on ID pin.
Date: Tue, 2 Jun 2015 22:47:57 +0200
Message-ID: <2A59C20E-580D-4284-83BA-1C36E996BEDC@goldelico.com>
References: <20150416075945.23307.24424.stgit@notabene.brown> <20150416080304.23307.41913.stgit@notabene.brown> <556C5FF4.3050603@ti.com> <20150602073731.26edbd3b@notabene.brown> <556DB481.3080906@ti.com> <C1222390-F14D-4E47-9F53-CD4646BF4450@goldelico.com> <20150602201143.GA26412@amd>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150602201143.GA26412@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, NeilBrown <neil@brown.name>, linux-omap <linux-omap@vger.kernel.org>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Am 02.06.2015 um 22:11 schrieb Pavel Machek <pavel@ucw.cz>:

> On Tue 2015-06-02 16:06:47, Dr. H. Nikolaus Schaller wrote:
>> Hi,
>>=20
>> Am 02.06.2015 um 15:49 schrieb Kishon Vijay Abraham I <kishon@ti.com=
>:
>>=20
>>> Hi,
>>>=20
>>> On Tuesday 02 June 2015 03:07 AM, NeilBrown wrote:
>>>> On Mon, 1 Jun 2015 19:06:52 +0530 Kishon Vijay Abraham I <kishon@t=
i.com>
>>>> wrote:
>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> On Thursday 16 April 2015 01:33 PM, NeilBrown wrote:
>>>>>> From: NeilBrown <neilb@suse.de>
>>>>>>=20
>>>>>> The twl4030 phy can measure, with low precision, the
>>>>>> resistance-to-ground of the ID pin.
>>>>>>=20
>>>>>> Add a function to read the value, and export the result
>>>>>> via sysfs.
>>>>>=20
>>>>> Little sceptical about adding new sysfs entries. Do you have a go=
od reason to
>>>>> add this?
>>>>=20
>>>> The hardware can report the value, so why not present it to user-s=
pace?
>>>>=20
>>>> I originally used this with a udev rule which would configure the =
maximum
>>>> current based on the resistance measure - to work with the particu=
lar charger
>>>> hardware I have.
>>>>=20
>>>> More recent patches try to do all of the max-current configuration=
 in the
>>>> kernel, so I could live without exporting the value via sysfs if t=
hat is a
>>>> show-stopper.
>>>>=20
>>>> I can't see where the scepticism comes from though.  It is a well =
defined
>>>> and cleary documented feature of the hardware.  Why not expose it?
>=20
> Is it well defined enough that it will work on other chargers, too?

It reports the resistance of the charger=92s ID pin. So that works for =
all chargers connected
to a twl4030. As long as the ID pin goes to a 5 pin USB socket.

Other charger drivers do not need to expose a similar attribute since e=
ach twl4030 has its
unique path within the /sys tree.

>=20
>>> ABI can never be removed or modified later. So should be really car=
eful before adding it.
>>=20
>> Is /sys considered ABI?
>=20
> Yes.

You are right: https://lwn.net/Articles/172986/

But I am as well with my doubts: https://lwn.net/Articles/173093/

>=20
>> User space developers are always reminded not to rely on /sys nodes.
>=20
> No.

Then please explain why I have the impression that it is quite unstable=
=2E

BR,
Nikolaus
