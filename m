From: Nishanth Menon <nm@ti.com>
Subject: Re: regressions in linux-next?
Date: Thu, 24 Apr 2014 10:46:59 -0500
Message-ID: <535931F3.10805@ti.com>
References: <53566C20.6000208@ti.com> <53566EBA.808@ti.com> <CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com> <CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com> <7hr44mpxk6.fsf@paris.lan> <CAGo_u6r79StfHwf8t8OB5vyhByfusi3EF=PZA186piiAci_wjw@mail.gmail.com> <20140424154031.GA22987@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35554 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758170AbaDXPrN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 11:47:13 -0400
In-Reply-To: <20140424154031.GA22987@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On 04/24/2014 10:40 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [140424 08:25]:
>> On Thu, Apr 24, 2014 at 10:16 AM, Kevin Hilman <khilman@linaro.org> wrote:
>>> Linus Walleij <linus.walleij@linaro.org> writes:
>>>
>>>> On Tue, Apr 22, 2014 at 5:52 PM, Javier Martinez Canillas
>>>> <javier@dowhile0.org> wrote:
[...]
>>>> We even tried to get an Innovator to boot just to be able to refactor
>>>> OMAP stuff but fell short on some special JTAG reflash snag so
>>>> we are dependent on maintainers to help out here :-/
>>>
>>> Unfortunately, my OMAP1 (omap5912/OSK[1]) died last year and I haven't been
>>> able to get it booting again.  I wonder if Spectrum Digital still has
>>> these available?  Their websites[1] says "call for price."
>>>
>>> Kevin
>>>
>>> [1] http://www.spectrumdigital.com/product_info.php?products_id=39
>>
>>
>> Perhaps dumb question: but are there folks who really care about omap1
>> boot anymore in upstream? should it be time to deprecate it - say for
>> 3.17 or so?
> 
> Why? There are people still using omap1 and it works just fine. And
> in general the maintenance work needed for omap1 is really minimal.
> 
> And in the GPIO case the issue was also discovered on new TI boards.
> 

I mean, yeah - hobby usage is nice.. but there is maintenance burden
when it comes to ensuring generic drivers such as timers, gpio etc.. I
am not saying we cannot maintain it, but if there are no strong
reasons why to keep it alive, it kinda reduces the scope of
modifications as kernel frameworks evolve to be generic. The OMAP1
generation of processors based boards are so hard to get and go
running that developer access to these boards slow things down as well.

I understand that "strong reasons to keep it alive" is pretty
subjective in nature.. but just throwing the thought out here.


-- 
Regards,
Nishanth Menon
