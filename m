From: Pontus Fuchs <pontus.fuchs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 5/6] ARM: dts: add wl12xx/wl18xx bindings
Date: Thu, 19 Mar 2015 15:05:53 +0100
Message-ID: <550AD7C1.2030405@gmail.com>
References: <1426696710-6891-1-git-send-email-eliad@wizery.com> <1426696710-6891-6-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426696710-6891-6-git-send-email-eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 2015-03-18 17:38, Eliad Peller wrote:
> Replace all the pdata-quirks for setting wl12xx/wl18xx
> platform data with proper DT definitions.
>
> Signed-off-by: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> Acked-by: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
> Acked-by: Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
> v7: rebase
>
>   arch/arm/boot/dts/am335x-evmsk.dts             | 11 ++++
>   arch/arm/boot/dts/omap3-cm-t3517.dts           | 10 ++++
>   arch/arm/boot/dts/omap3-cm-t3730.dts           | 10 ++++
>   arch/arm/boot/dts/omap3-evm-common.dtsi        | 10 ++++
>   arch/arm/boot/dts/omap3-igep0020-rev-f.dts     |  9 ++++
>   arch/arm/boot/dts/omap3-igep0030-rev-g.dts     |  9 ++++
>   arch/arm/boot/dts/omap3-zoom3.dts              | 10 ++++
>   arch/arm/boot/dts/omap4-panda-common.dtsi      | 10 ++++

Hi Eliad,

Tested OK (boot, scan, join, ping) on Pandaboard ES.

BR,

Pontus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
