From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
Date: Wed, 6 Jul 2011 18:12:49 -0600
Message-ID: <CACxGe6u8qq7FA7kFXbU5uCk6m_GA8GWLqsdjFCXN+NMJfFKxmA@mail.gmail.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
 <1309426647-31587-2-git-send-email-manjugk@ti.com> <20110706185546.GJ4871@ponder.secretlab.ca>
 <74CDBE0F657A3D45AFBB94109FB122FF049E21C203@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049E21C203-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 6, 2011 at 5:26 PM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wro=
te:
> Grant Likely wrote at Wednesday, July 06, 2011 12:56 PM:
>> On Thu, Jun 30, 2011 at 03:07:23PM +0500, G, Manjunath Kondaiah wrot=
e:
>> > Add I2C and it's child device nodes for beagle board.
>> > The I2C1 controller child devices are not populated and it
>> > should be handled along with OMAP clock changes.
> ...
>> > diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dt=
s/omap3-beagle.dts
> ...
>> > + =A0 i2c@48070000 {
> ...
>> > + =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <2600>;
>> > + =A0 =A0 =A0 =A0 =A0 status =3D "disabled";
>>
>> Drop 'status' when you move this node definition to
>> arch/arm/boot/dts/omap3.dtsi. =A0Board overlay files that include th=
e
>> omap3.dtsi should explicitly disable any devices that it does not us=
e
>> (which is opposite to what tegra currently does, but I'm going to
>> change that).
>
> Purely out of idle curiosity: What's the benefit of one way over the =
other?

Mostly consistency.  Most of the experience we have with the flattened
device tree up to this point hasn't bothered with the 'status'
property.  It is only when AMP and hypervisors cam online that it
became important to use a status property, and that only when the
kernel needs to be told that the device does indeed exist, but it must
not be touched.  I'd like to continue that pattern for new DT users
with the default assumption that a device is enabled unless the board
=2Edts explicitly disables it.

g.
