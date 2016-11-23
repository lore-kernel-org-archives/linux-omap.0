From: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: mfd: Improve readability for TPS65217
 interrupt sources
Date: Wed, 23 Nov 2016 22:06:18 +0900
Message-ID: <27c48fc3-29bd-996b-bdc4-75884a39865a@gmail.com>
References: <20161121131515.8040-1-woogyom.kim@gmail.com>
 <20161122155759.GG10134@dell.home>
 <bd4944d8-3cef-b3f7-4fba-6de590493047@gmail.com>
 <33562327.jVWx4tN2gP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <33562327.jVWx4tN2gP@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/23/2016 08:51 PM, Arnd Bergmann wrote:
> Ah, the numbers come from the data sheet. Please just remove the
> header then, there is no need to keep them as an ABI, in particular
> when the driver doesn't even include that header today.

Got it.

> What matters here is the binding documentation in
> Documentation/devicetree/bindings/power/supply/tps65217_charger.txt

OK, in addition to this, the interrupt specifier needs to be added in 
Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt.

> Please fix that instead to mandate that the two interrupts are
> required, what their functions are, and what the interrupt-names
> (not interrupts-names) property must list.

Oops, wrong interrupt name property - my bad.

Thanks for all your feedback.

Best regards,
Milo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
