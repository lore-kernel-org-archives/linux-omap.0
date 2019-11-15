From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: Sense of soc bus? (was: [PATCH] base: soc: Export
 soc_device_to_device() helper)
Date: Fri, 15 Nov 2019 13:00:59 +0100
Message-ID: <a0a6d71f-4fb7-51ce-fe33-74f9e588b791@suse.de>
References: <20191103013645.9856-3-afaerber@suse.de>
 <20191111045609.7026-1-afaerber@suse.de> <20191111052741.GB3176397@kroah.com>
 <586fa37c-6292-aca4-fa7c-73064858afaf@suse.de>
 <20191111064040.GA3502217@kroah.com>
 <a88442df-dc6b-07e5-8dee-9e308bdda450@suse.de>
 <20191112052347.GA1197504@kroah.com>
 <20191112072926.isjxfa4ci6akhx56@pengutronix.de>
 <aff81b8e-f041-73a5-6a95-d308fa07842c@suse.de>
 <c8572f70-5550-8cee-4381-fd7de7ae5af0@baylibre.com>
 <CAMuHMdWOWWQoJh5=07VMRhtrFR_Gc_qNhjTV4tCsvwvMn0kYfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWOWWQoJh5=07VMRhtrFR_Gc_qNhjTV4tCsvwvMn0kYfA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-realtek-soc@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>, NXP Linux Team <linux-imx@nxp.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, boot-architecture@lists.linaro.org, Sascha Hauer <s.hauer@pengutronix.de>, Fabio
List-Id: linux-omap@vger.kernel.org

Hi Geert,

Am 15.11.19 um 09:58 schrieb Geert Uytterhoeven:
> On Fri, Nov 15, 2019 at 9:52 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>> On 12/11/2019 11:47, Andreas Färber wrote:
>>> For example, RTD1295 will support LSADC only from revision B00
>>> on (and it's not the first time I'm seeing such things in the industry).
>>> So if a user complains, it will be helpful to see that information.
>>>
>>> Referencing your Amlogic review, with all due respect for its authors,
>>> the common framework here just lets that information evaporate into the
>>> deeps of sysfs.
>>
>> Hopefully we never had the case where needed to use the soc info in drivers,
>> but now we have one and having such infrastructure already in-place will help.
>>
>> Renesas platforms makes a extensive usage of the soc info infrastructure to
>> figure out plenty of HW parameters at runtime and lower their DT changes.
> 
> We do our best to use it solely for detecting quirks in early SoC revisions.

Got a pointer? I fail to immediately understand how sysfs would help
drivers (as opposed to userspace) detect quirks: Parsing strings back
doesn't sound efficient, and I don't see you exporting any custom APIs
in drivers/soc/renesas/renesas-soc.c?

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
