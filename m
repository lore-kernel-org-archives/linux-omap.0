From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 2/4] Documentation: dt: add bindings for ti-cpufreq
Date: Fri, 10 Feb 2017 14:55:29 -0600
Message-ID: <4af419d0-9730-756f-916d-88e07e704448@ti.com>
References: <20170203172929.23940-3-d-gerlach@ti.com>
 <CAJZ5v0hT4peuRQUrLHC32GmVSoa6Npv2qutNo2WEhne72hHi6A@mail.gmail.com>
 <20170210031349.GG14503@vireshk-i7> <3046998.7dExGlRDb3@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3046998.7dExGlRDb3-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Lukasz Majewski <lukma-ynQEQJNshbs@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 02/10/2017 06:28 AM, Rafael J. Wysocki wrote:
> On Friday, February 10, 2017 08:43:49 AM Viresh Kumar wrote:
>> On 09-02-17, 23:03, Rafael J. Wysocki wrote:
>>> In particular, Viresh, if you ACK something, please make sure that it
>>> doesn't conflict with your own patches.
>>
>> I hope you are talking about the patch 3/4 for which Arnd also sent a
>> fix.  I acked it back on 18th of January and Dave has been carrying my
>> Ack since then. When he posted again, I didn't went into reviewing it
>> again as I saw my Ack being there.
>
> Well, OK, but you did know that the OPP API had changed in the meantime,
> so it wouldn't have hurt to double check I suppose?
>
>> Yes, he ended up using an API which just got updated after 18th of Jan
>> and yes both me and Dave missed that. But I feel it is difficult to
>> take care of scenarios like this. Perhaps he should have made sure
>> that he base it of pm/linux-next and nothing would have gone wrong.
>
> Yes, that would help, but then how to enforce that?

I apologize, I was unaware of the conflicting series. I'm not sure of a good way 
to enforce it but I do agree I will make sure to rebase and test against 
pm/linux-next before sending in the future.

Regards,
Dave

>
> Thanks,
> Rafael
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
