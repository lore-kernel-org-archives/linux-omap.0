From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 04/11] MFD: twl4030-audio: Add DT support
Date: Wed, 08 Aug 2012 17:31:19 +0300
Message-ID: <50227837.10400@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com> <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com> <20120808131356.GS16861@opensource.wolfsonmicro.com> <50226CF4.1010202@ti.com> <20120808135253.GC16861@opensource.wolfsonmicro.com> <502274DA.9020204@ti.com> <20120808141849.GA24328@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120808141849.GA24328@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

On 08/08/2012 05:18 PM, Mark Brown wrote:
> I'm struggling to see any reason not to just hold the external mute o=
n
> for the entire time the headset is powered off?

I think because it would mean in most cases that we keep a GPIO line en=
abled
during the time the HS is not in use, which burns power.
In most cases the mute is enabled when the GPIO line is up.

>> If you are OK with the hassle I can add a patch to the series for
>> include/linux/of.h to handle this.
>=20
> Yes, please.

I'll wait for more comments and I'll include it to v2.

--=20
P=E9ter
