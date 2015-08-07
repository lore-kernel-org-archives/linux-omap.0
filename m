From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] omap: Fix broken pbias device creation
Date: Fri, 7 Aug 2015 12:48:26 +0100
Message-ID: <CALeDE9OBjESdkXhkAEVj1L-XKJ1yoFg8rkHvcJ_Uj_RXOC-yUQ@mail.gmail.com>
References: <1437999401-3519-1-git-send-email-kishon@ti.com>
	<55B89590.6000109@ti.com>
	<20150805100009.GY16878@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150805100009.GY16878-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, t-kristo-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 5, 2015 at 11:00 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [150729 02:01]:
>> On 07/27/2015 03:16 PM, Kishon Vijay Abraham I wrote:
>> >pbias device creation got broken once SCM cleanup got merged.
>> >This patch series re-enables device creation by adding
>> >"simple-bus" in the compatible property of the syscon
>> >dt node.
>> >
>> >validated this series in DRA72, OMAP4 PANDA and OMAP5 UEVM
>> >boards.
>> >
>> >Kishon Vijay Abraham I (4):
>> >   ARM: dts: omap24xx: Fix broken pbias device creation
>> >   ARM: dts: OMAP4: Fix broken pbias device creation
>> >   ARM: dts: OMAP5: Fix broken pbias device creation
>> >   ARM: dts: dra7: Fix broken pbias device creation
>> >
>> >  arch/arm/boot/dts/dra7.dtsi     |    2 +-
>> >  arch/arm/boot/dts/omap2430.dtsi |    3 ++-
>> >  arch/arm/boot/dts/omap4.dtsi    |    3 ++-
>> >  arch/arm/boot/dts/omap5.dtsi    |    3 ++-
>> >  4 files changed, 7 insertions(+), 4 deletions(-)
>> >
>>
>> For dra7-evm:
>> Tested-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>
> Applying all into omap-for-v4.2fixes-v2 thanks.

Do we need the same for am33xx.dtsi too given commit e3bc5358e097 ?

Peter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
