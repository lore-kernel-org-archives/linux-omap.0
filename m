From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RESEND 0/4] arm: dts: am57xx: Correct the thermal
 thresholds
Date: Tue, 10 May 2016 09:54:02 +0530
Message-ID: <57316262.80003@ti.com>
References: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461837949-11116-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony,

On Thursday 28 April 2016 03:35 PM, Keerthy wrote:
> Noticed that earlier post had a wrong list name hence resending the
> series.
>
> Currently all the am57xx versions are wrongly re-using the dra7  thermal
> threholds. Introduing the correct thermal thresholds based on industrial
> or commercial grade silicon present on the individual boards.
>
> Tested on AM57XX-BEAGLE-X15 (Commercial) and AM572X-IDK(Industrial)
> for the trip_point node sysfs temperatures.
>

A Gentle ping on this series.

> These patches are on top of:
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/tmlind/linux-omap/+/omap-for-v4.7/dt
>
> Keerthy (4):
>    ARM: dts: am57xx: Introduce commercial grade thermal thresholds
>    ARM: dts: am57xx: Introduce industrial grade thermal thresholds
>    ARM: dts: am57xx: Include the commercial grade thresholds
>    ARM: dts: am57xx-idk: Include Industrial grade      thermal thresholds
>
>   arch/arm/boot/dts/am57xx-beagle-x15.dts        |  1 +
>   arch/arm/boot/dts/am57xx-commercial-grade.dtsi | 23 +++++++++++++++++++++++
>   arch/arm/boot/dts/am57xx-idk-common.dtsi       |  2 ++
>   arch/arm/boot/dts/am57xx-industrial-grade.dtsi | 23 +++++++++++++++++++++++
>   4 files changed, 49 insertions(+)
>   create mode 100644 arch/arm/boot/dts/am57xx-commercial-grade.dtsi
>   create mode 100644 arch/arm/boot/dts/am57xx-industrial-grade.dtsi
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
