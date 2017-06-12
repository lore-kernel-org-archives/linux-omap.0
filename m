From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v5 3/3] drivers:power:twl4030-charger: add deferred probing for phy and iio
Date: Mon, 12 Jun 2017 19:02:09 +0200
Message-ID: <D12A5BD7-65A1-49E6-A25C-B2A2162FCA05@goldelico.com>
References: <cover.1495363097.git.hns@goldelico.com> <6ed105f6c9c21c24184913a7be9e665453549d79.1495363097.git.hns@goldelico.com> <20170607204444.zumcreuqdnv7euv2@earth> <01A3D2F5-9E09-4E93-A363-93130DCEB7DF@goldelico.com> <1b9f3e92-36ac-2a73-7b2d-037b19fafaad@ti.com> <DC2DA07F-72A1-45B9-A4F5-BD83D930974D@goldelico.com> <754fbc28-f5ff-4736-1d46-f467667b130d@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <754fbc28-f5ff-4736-1d46-f467667b130d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Marek Belisko <marek@goldelico.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

> Am 12.06.2017 um 18:24 schrieb Grygorii Strashko =
<grygorii.strashko@ti.com>:
>=20
>=20
>=20
> On 06/09/2017 11:59 PM, H. Nikolaus Schaller wrote:
>> Hi Grygorii,
>>=20
>>> Am 09.06.2017 um 18:25 schrieb Grygorii Strashko =
<grygorii.strashko@ti.com>:
>>>=20
>>>=20
>>>>=20
>>>> So please advise how to proceed.
>>>>=20
>>>=20
>>> You should request irq as late as possible in probe - it's safest =
way to go always.
>>> You see crushes simply because request_irq enables IRQ and IRQ can =
trigger immediately, so
>>> IRQ handler will run and all required resources should be ready and =
initialized.
>>>=20
>>> In this case:
>>> twl4030_bci_interrupt() -> twl4030_charger_update_current() -> =
ac_available() -> iio_read_channel_processed()
>>> OOOPS.
>>>=20
>>> So, first thing to do is to reorder probe to ensure that sequence is =
safe.
>>=20
>> That is exactly what I guessed when proposing the reordering patch.
>>=20
>>> Then other stuff - devm, EPROBE_DEFER ...
>>=20
>> IMHO, reordering alone doesn't make much sense as a single patch. Or =
does it?
>>=20
>=20
> The question is - is there bug in driver or not? As per current code =
seems yes.

If we all agree, do we need another confirmation?

> You can easily test it by directly calling twl4030_charger_interrupt() =
right after
> IRQ is requested. there is a bug if it will crush.

In the variant without EPROBE_DEFER you won't see it since ac_available =
either
has a valid iio channel or NULL.

The problem is only if we add an EPROBE_DEFER return if getting the iio =
channel
fails. This seems to make trouble if we don't take care of it. There are =
certainly
several options to work around but IMHO reordering is the best one (and =
even works
w/o devm for iio - which should be added in a separate step).

And there is a strong argument for reordering to have the most likely =
failure
first (iio fails more likely due to DEFER than allocating an irq). But =
only if
we process the iio failure at all.

So there are one a little doubtful argument for reordering (driver bug) =
and
a strong one.

> As for me it more reasonable to move forward using smaller steps.

Well, I wonder what it does help to fix a bug which does not even become =
visible
if we don't add EPROBE_DEFER?

So I would count two steps:
a) add EPROBE_DEFER and reorder code to make it work
b) convert to devm for iio

Ok?

BR and thanks,
Nikolaus
