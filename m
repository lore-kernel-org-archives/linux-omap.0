From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v3 2/3] iio:adc:palmas: add DT support
Date: Mon, 19 Oct 2015 14:30:33 +0200
Message-ID: <6E3CF32E-809D-4BA4-BD78-E10192B2C91C@goldelico.com>
References: <cover.1445000017.git.hns@goldelico.com> <79429ca1a6d0465b6b19ede16d90de23e4363431.1445000017.git.hns@goldelico.com> <5624DAAB.9040207@metafoo.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5624DAAB.9040207-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Pradeep Goudagunta <pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Am 19.10.2015 um 13:57 schrieb Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>:

> On 10/16/2015 02:53 PM, H. Nikolaus Schaller wrote:
> [...]
>> +Optional sub-nodes:
>> +ti,channel0-current-microamp: Channel 0 current in uA.
>> +	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
>> +ti,channel3-current-microamp: Channel 3 current in uA.
>> +	Valid are rounded to derive 0uA, 10uA, 400uA, 800uA.
>> +ti,enable-extended-delay: Enable extended delay.
> 
> Those three above sound more like configuration policy, rather than hardware
> description. What influence which values should be chosen?

e.g. the nominal value of the NTC that can be connected if the Palmas
is hooked up in a standard way.

If a board has no NTC and uses channel0 for a different purpose one
should choose 0uA.

If it is let's say 10kOhm it should probably be 20uA to give a nominal voltage
reading of 200mV.

100kOhm will give 2V which is at the limit of the ADC input range and
therefore it would be better to choose 15uA or 5uA.

I think choosing extended delay depends on the noisiness of the input
signal but I am not a specialist for this feature.

So I would say the board hardware mandates some specific value.

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
