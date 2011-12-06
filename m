From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] mfd: add bq2415x charger driver
Date: Tue, 6 Dec 2011 02:12:47 +0200
Message-ID: <CAMP44s1TrRkcy-xS+fXMyv0FAL1TnsPnnTa=gHSd2=P=iFkSUg@mail.gmail.com>
References: <1323124541-7590-1-git-send-email-felipe.contreras@nokia.com>
	<2013134.msetbOSBe8@pali-elitebook>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2013134.msetbOSBe8@pali-elitebook>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Aliaksei Katovich <aliaksei.katovich@nokia.com>, Vladimir Zapolskiy <vz@mleia.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Dec 6, 2011 at 1:05 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> I started writing other implementaion of bq2415x charger driver, whic=
h should
> support also setting usb host mode. Code is still unfinished, but now=
 is
> devided into 2 parts: one power_supply driver and one driver which co=
ver all
> bq registers. See:
>
> http://atrey.karlin.mff.cuni.cz/~pali/bq2415x/
>
> Felipe Contreras, I think that my implementation is better - it will =
export
> all bq registers (which is needed for hostmode boost) and will also r=
egister
> regulator interface.

I took a look at your driver, and there's definitely good stuff in it.
However, I think there's a lot of unnecessary stuff, like the
miscdevice stuff (which was frowned upon for bq27x00), and a lot of
user-space interface. Moreover, it doesn't seem to do anything on its
own (it needs interaction from user-space).

IMO the first step should be to have a minimal driver that just works,
even if it doesn't achieve the absolute best charging performance.
More features could be added later on.

Also, I'm not familiar with the regulator interface, but it seems to
be meant for real regulators, which have consumers, and based on those
consumers's needs the real voltage changes. This battery charger on
the other hand doesn't have anything like that. There will be no
consumer, and some stuff like the weak battery voltage is not even
related to a voltage supply, but rather a threshold that can be
configured to change some behavior of the charger, but there's no
point in changing it dynamically (or maybe at all).

I guess the important one is the charge voltage, which is linked to a
real voltage, but what consumers would it have? I don't think there's
any.

=46inally, I don't think user-space interaction should be needed at all=
=2E
The driver should start charging immediately when there power supply
available, and stop when there isn't any. Maybe at some point a
user-space interface will be useful later on (I don't see why), but I
don't think it should be *necessary*.

I'm not familiar with any of this stuff, so don't take my opinions too
seriously :)

Cheers.

--=20
=46elipe Contreras
