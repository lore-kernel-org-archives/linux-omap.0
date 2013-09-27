From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC v2] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Sat, 28 Sep 2013 00:16:20 +0530
Message-ID: <5245D27C.8080901@ti.com>
References: <1380009480-4975-1-git-send-email-javier.martinez@collabora.co.uk> <5244C0C4.2030004@wwwdotorg.org> <52453545.3090504@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52453545.3090504-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jon Hunter <jgchunter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, r.sricharan-l0cyMroinI0@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, joelf-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 9/27/2013 1:05 PM, Javier Martinez Canillas wrote:
> On 09/27/2013 01:18 AM, Stephen Warren wrote:
>> On 09/24/2013 01:58 AM, Javier Martinez Canillas wrote:
>>> The OMAP GPIO controller HW requires a pin to be configured in GPIO
>>> input mode in order to operate as an interrupt input. Since drivers
>>> should not be aware of whether an interrupt pin is also a GPIO or not,
>>> the HW should be fully configured/enabled as an IRQ if a driver solely
>>> uses IRQ APIs such as request_irq(), and never calls any GPIO-related
>>> APIs. As such, add the missing HW setup to the OMAP GPIO controller's
>>> irq_chip driver.
>>>
>>> Since this bypasses the GPIO subsystem we have to ensure that another
>>> caller won't be able to request the same GPIO pin that is used as an
>>> IRQ and set its direction as output. Requesting the GPIO and setting
>>> its direction as input is allowed though.
>> FWIW, the concept of this patch,
>> Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> I didn't review the code; just skimmed it to see where the new
>> functionality was implemented.
>>
> Thanks Stephen,
>
> I split the changes as suggested by Tony and posted as a patch-set and not an
> RFC anymore:
>
> [PATCH 1/2] gpio/omap: maintain GPIO and IRQ usage separately [1]
> [PATCH 2/2] gpio/omap: auto-setup a GPIO when used as an IRQ [2]
>
> Linus,
>
> Could you please add Stephen Acked-by when taking the patches and also George
> Cherian Tested-by that sent for this RFC. George it would be great if you can
> also comment on which OMAP platform you had tested.

Tested on dra7xx/evm with GPIO interrupt for pcf gpio expander.
Tested-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
>
> I cc'ed Aaro Koskinen and Paul Walmsley now which seems to have OMAP1 platforms
> to test. Could you please test [1] and [2] on a OMAP1 board? These patches
> solves a long standing issue we have on OMAP2+ when booting with DT and it would
> be great if you can check that it does not cause regressions on OMAP1 based boards.
>
> Thanks a lot and best regards,
> Javier
>
> [1]: https://patchwork.kernel.org/patch/2937351/
> [2]: https://patchwork.kernel.org/patch/2937371/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
-George

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
