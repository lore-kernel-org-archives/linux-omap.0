From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/8] Droid4 DTS update
Date: Wed, 1 Mar 2017 17:37:08 -0800
Message-ID: <20170302013707.GK20572@atomide.com>
References: <20170302010900.28532-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170302010900.28532-1-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170301 17:10]:
> Hi,
> 
> Tony, since your omap4-droid4 dts patches were not
> yet in a public repository and they would merge conflict
> with my patches I put them all together into a single
> patchset. I also added my Tested-By to your patches.

OK

> The mounting-matrix for the sensors and the touchscreen's 
> rotation assume, that the phone's default rotation is vertical.
> I think that's sensible, because
> 
>  * Android on the phone uses this as default rotation
>    (like almost? all other phones)
>  * volume buttons make sense (in horizontal position one
>    would expect, that left button means lower volume. I
>    know at least Maemo swaps them)
> 
> That should cover all mainline drivers.

Heheheh cool looks like you configured compass and accelerometer :)

I have a better touchscreen patch that also configures the wakeirq
that I did not post yet at http://muru.com/linux/d4/patches/ in the
updated set droid4-wip-next-20170217.tar.gz.

I have few more interesting ones coming, I got the HDMI working
reliably over the weekend. I was planning on waiting until -rc1 to
post them but let's see if I can send few patches out before that.

Anyways, I'll post a better touchscreen patch then let's apply these
into omap-for-v4.12/dt-droid4 branch when -rc1 is tagged.

Regards

Tony


> Sebastian Reichel (6):
>   ARM: dts: omap4-droid4: Add gpio-keys
>   ARM: dts: motorola-cpcap-mapphone: add rtc
>   ARM: dts: motorola-cpcap-mapphone: add pwrbutton
>   ARM: dts: omap4-droid4: Add compass
>   ARM: dts: omap4-droid4: Add accelerometer
>   ARM: dts: omap4-droid4: Add touchscreen
> 
> Tony Lindgren (2):
>   ARM: dts: omap4-droid4: Configure regulators
>   ARM: dts: omap4-droid4: Add keypad support
> 
>  arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 164 ++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4-droid4-xt894.dts       | 165 +++++++++++++++++++++----
>  2 files changed, 308 insertions(+), 21 deletions(-)
>  create mode 100644 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> 
> -- 
> 2.11.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
