From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Tue, 24 Sep 2013 13:09:18 +0530
Message-ID: <524141A6.2090701@ti.com>
References: <1379860848-29020-1-git-send-email-javier.martinez@collabora.co.uk> <20130923164519.GF2684@atomide.com> <524073BC.9080907@collabora.co.uk> <20130923170724.GG2684@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130923170724.GG2684-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, Jon Hunter <jgchunter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,
On Monday 23 September 2013 10:37 PM, Tony Lindgren wrote:
> * Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [130923 10:09]:
>> On 09/23/2013 06:45 PM, Tony Lindgren wrote:
>>> Hmm does this still work for legacy platform data based
>>> drivers that are doing gpio_request() first?
>>>
>> Yes it still work when booting using board files. I tested on my OMAP3 board and
>> it worked in both DT and legacy booting mode.
> OK great.
>  
>>> And what's the path for clearing things for PM when free_irq()
>>> gets called? It seems that this would leave the GPIO bank
>>> enabled causing a PM regression?
>>>
>> Indeed, I did set bank->mod_usage |= 1 << offset so the bank is enabled if the
>> device goes to suspended and then resumed but I completely forget about the
>> clearing path when the IRQ is freed.
>>
>> Which makes me think that we should probably maintain two usage variables, one
>> for GPIO and another one for IRQ and check both of them on the suspend/resume pm
>> functions.
> Yes that it seems that they should be treated separately.
 To understand, why cant the flag be cleared in gpio_irq_shutdown ?

Regards,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
