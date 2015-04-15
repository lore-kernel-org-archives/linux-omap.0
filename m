From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] pinctrl: bindings: pinctrl: Add support for TI's
 IODelay configuration
Date: Wed, 15 Apr 2015 11:51:32 -0500
Message-ID: <552E9714.10001@ti.com>
References: <1425427237-11511-1-git-send-email-nm@ti.com> <1425427237-11511-2-git-send-email-nm@ti.com> <CACRpkdaLEPzBywMnMrteboK7Q4su8PoB0wjnGvVpgUJ=2czVxQ@mail.gmail.com> <20150310153321.GO5264@atomide.com> <54FF28F5.4040707@ti.com> <20150310173115.GS5264@atomide.com> <54FF38F3.2030703@ti.com> <CACRpkdZ1faucps07jaT9kOyviC+Sw6gPkbF=cAGCUj+DiaEgTA@mail.gmail.com> <20150318014151.GL31346@atomide.com> <20150415012910.GA29560@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150415012910.GA29560-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lennart Sorensen <lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/14/2015 08:29 PM, Lennart Sorensen wrote:
> On Tue, Mar 17, 2015 at 06:41:51PM -0700, Tony Lindgren wrote:
>> Yeah agreed. I suggest discussing the binding and the generic
>> parsing code for it first :)
>>  
>> It seems with the generic binding the actual driver should be
>> just the hardware specific code hopefully.
> 
> Did this thread go anywhere in the last month?  I am certainly looking
> forward to seeing what the resolution is to this, given for our use the
> boot loader setup is not appealing at all.
> 
I am yet to post a new revision to this series - few other stuff got
in the way. IODelay driver in no way removes the constraint that the
SoC architecture has - most of the pins still need to be muxed in
bootloader - we cannot escape that. The reasoning for doing the mux in
bootloader is independent of the need for iodelay.

Reasoning for mux in bootloader is because the mux and pull fields are
glitchy - much more than previous generations of TI SoCs and
significantly long enough to cause issues depending on the pins being
muxed.

Reasoning for iodelay is different - it is a hardware block meant to
control the timing of signals in a particular signal path to ensure
that specification compliance is met.

Lets try not to mix the two.

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
