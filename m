From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
Date: Wed, 20 Jul 2011 17:14:05 -0600
Message-ID: <CACxGe6utwx_LpMx0sqfuTRLst1-0eoi8ZrwA2ZVRyjiVzxKT1g@mail.gmail.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
 <1309426647-31587-2-git-send-email-manjugk@ti.com> <20110706185546.GJ4871@ponder.secretlab.ca>
 <74CDBE0F657A3D45AFBB94109FB122FF049E21C203@HQMAIL01.nvidia.com>
 <CACxGe6u8qq7FA7kFXbU5uCk6m_GA8GWLqsdjFCXN+NMJfFKxmA@mail.gmail.com>
 <20110720110419.GA6999@S2100-06.ap.freescale.net> <20110720185513.GI4642@ponder.secretlab.ca>
 <20110720223348.GH6999@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110720223348.GH6999-+NayF8gZjK2ctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 20, 2011 at 4:33 PM, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wr=
ote:
> On Wed, Jul 20, 2011 at 12:55:13PM -0600, Grant Likely wrote:
>> On Wed, Jul 20, 2011 at 07:04:20PM +0800, Shawn Guo wrote:
>> > > Mostly consistency. =A0Most of the experience we have with the f=
lattened
>> > > device tree up to this point hasn't bothered with the 'status'
>> > > property. =A0It is only when AMP and hypervisors cam online that=
 it
>> > > became important to use a status property, and that only when th=
e
>> > > kernel needs to be told that the device does indeed exist, but i=
t must
>> > > not be touched. =A0I'd like to continue that pattern for new DT =
users
>> > > with the default assumption that a device is enabled unless the =
board
>> > > .dts explicitly disables it.
>> [...]
>> > Besides the bothering that we have to list so many unused controll=
ers
>> > in individual board dts file, it's also hard to tell which control=
lers
>> > are actually available on the board. =A0People have to look at imx=
53.dts
>> > to get a full list and then exclude the ones in imx53-<board>.dts =
as
>> > "disabled".
>> >
>> > And if we go the way opposite, adding "disabled" status for everyo=
ne
>> > in imx53.dts, we will only need to specify the peripherals that ar=
e
>> > actually available on board with "okay" status in imx53-<board>.dt=
s.
>> > And it's much more clear for people to see what peripherals are
>> > available on individual board.
>> >
>> > So I'm going the way than you suggested. =A0Please let me know if =
you
>> > strongly dislikes it.
>>
>> Yes, I strongly dislike it. =A0I understand the concern, but at this
>> early stage with converting to device tree I think consistency betwe=
en
>> platforms is more important. =A0We can talk about the issue at Linar=
o
>> Connect in 2 weeks, but in the mean time please use the
>> enabled-by-default/explicitly-disabled pattern.
>>
> Okay, hope you will not ask me to use the opposite pattern when you
> actually see the patch :)

:-)

g.
