From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 6/8] drivers:input:ads7846(+tsc2046): fix spi module table
Date: Sun, 29 Jan 2017 19:25:43 +0100
Message-ID: <A169CC1E-9EC9-43CA-887B-1382F1903CE1@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <c79bdd79a22dab877b8a80136ac253c951698745.1482936802.git.hns@goldelico.com> <20170128193558.GC38136@dtor-ws> <F39E49DD-45AF-4491-A26E-F3A9D86F30F6@goldelico.com> <20170129180108.GA10743@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20170129180108.GA10743@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Petr Cvek <petr.cve>
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

> Am 29.01.2017 um 19:01 schrieb Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
>=20
> On Sun, Jan 29, 2017 at 09:39:39AM +0100, H. Nikolaus Schaller wrote:
>> Hi Dmitry,
>>=20
>>> Am 28.01.2017 um 20:35 schrieb Dmitry Torokhov =
<dmitry.torokhov@gmail.com>:
>>>=20
>>> On Wed, Dec 28, 2016 at 03:53:21PM +0100, H. Nikolaus Schaller =
wrote:
>>>> Fix module table so that the driver is loaded if compiled
>>>> as module and requested by DT.
>>>>=20
>>>=20
>>> I believe I already replied to a similar patch: we alreadyhave =
necessary
>>> aliases in this driver, we need to fix module loading to use it.
>>=20
>> Yes, you did comment on [PATCH v6 7/8] (19 Nov 2016):
>>=20
>>>> We really need to fix it between spi/i23c core and module utils =
instead
>>>> of keeping adding duplicate IDs all over drivers. We already have =
OF
>>>> module device table containing the same data, we should be able to =
use
>>>> it.
>>=20
>> And Javier Martinez Canillas replied (23 Nov 2016):
>>=20
>>> Agreed, unfortunately until the I2C and SPI core are changed to =
properly
>>> report OF modaliases, we will have to keep adding these duplicated =
IDs.
>>>=20
>>> And changing the I2C and SPI core isn't trivial since it could break =
a
>>> lot of drivers that rely on a platform modalias being reported (i.e: =
no
>>> OF device IDs present in the drivers even when are registered via =
DT).
>>=20
>> Therefore I didn't see a need to change it.
>=20
> I agree that changing I2C and SPI core is not trivial, however this is
> no reason for piling up workarounds in all drivers. Are you seriously
> advocating going though *every* driver and copying OF data into =
I2C/SPI
> instead of doing the right thing and fixing the root of the issue?

If you prefer to have this done (and I agree it would be a tiny =
improvement),
please do it for us all. But please after merging this workaround.

I can't do it since I have no idea how to and as you say it is =
non-trivial.
I am just a poor driver developer who has to use what he finds in core =
APIs
but has the task to make the driver work and be accepted upstream.

What I don't like is if core development tasks are piggybacked on top of =
a
driver patch series and used as argument against acceptance of the =
driver
patch. IMHO, the core developers should have the task to clean up such
workarounds after developing a modification for core and it seems to be
common practise in other subsystems if you follow what Linus is merging
every week.

Anyways, it piles up only in code. If you do not CONFIG the driver it =
does
not even matter that there are 10 more source code lines. And they are
factored out into a clean patch 6/8 that can easily be reverted.

BR and thanks,
Nikolaus

