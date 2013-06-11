From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 4
Date: Tue, 11 Jun 2013 17:29:22 +0200
Message-ID: <51B74252.5090906@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <20130611142358.GG29135@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130611142358.GG29135@zurbaran>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/11/2013 04:23 PM, Samuel Ortiz wrote:
> Hi Sebastian,

Hi Samuel,

> On Tue, Jun 11, 2013 at 01:30:46PM +0200, Sebastian Andrzej Siewior w=
rote:
>> I believe the whole thing should go via the MFD tree. It touches als=
o
>> input & iio subsystem. I collected ACKs where I got some in the mean=
time.
> Please fix your commit logs, and your subject lines. It should be e.g=
=2E
> mfd: input: ti_am335x_adc: Blablabla
>=20
> if it's mostly an mfd patch that also touches an input driver.

I usually do "subsystem / driver: short description" but if you want
the ":" as delimiter I can do this.

> Then, this is a pretty big patchset, with iio, input and mfd all mixe=
d
> together and it is likely to create merge conflicts.
They somehow depend on each other. Otherwise I would have sent three
series, one per subsystem.

>>From what I can see from it, and please correct me if I'm
> wrong, the iio and input changes depend on the mfd ones, and not the
> other way around. If that's so, I'm going to ask you to reshuffle you=
r
> patch set and separate the MFD changes from the iio and input ones. I=
'll
> take the MFD ones and will create an immutable branch for Jonathan an=
d
> Dmitry to pull from and apply the iio and input changes on top of it.
> Merge conflicts should be mostly avoided that way.
> AFAICT, only patch #2 should be kept with input and iio bits mixed
> together with MFD as otherwise this would introduce functional breaka=
ge.
> Otherwise, all MFD bits from the other patches could be either separa=
ted
> or merged together (e.g. MFD bits from patches #6 and #8, and #16 and
> #17).
>=20
> Does that sound doable to you ?

The device renaming shouldn't matter since I added DT nodes for the mfd
child devices earlier. But then the of_compatible assignments should
go hand in hand. However if I split this then the driver won't work
but then it does not now as well (because there is no platform_data
provider in tree).

Still. There is #18 which reworks the "step addressing" and involves
changes in both (iio & input) at the same time.
There is #21. Adding this to the initial "DT support" patch would be ba=
d
I think because it requires some changes on the iio side which have
nothing to do with DT. Putting the iio changes before DT would require
to make some change to platform-data part which will go away anyway.

So I started collecting ACKs from input and iio to avoid this split. If
you really want the split then I will start doing so=85

> Cheers,
> Samuel.

Sebastian
