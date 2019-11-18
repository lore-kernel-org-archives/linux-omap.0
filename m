From: Tony Lindgren <tony@atomide.com>
Subject: Re: Sense of soc bus? (was: [PATCH] base: soc: Export
 soc_device_to_device() helper)
Date: Mon, 18 Nov 2019 07:55:39 -0800
Message-ID: <20191118155539.GB35479@atomide.com>
References: <586fa37c-6292-aca4-fa7c-73064858afaf@suse.de>
 <20191111064040.GA3502217@kroah.com>
 <a88442df-dc6b-07e5-8dee-9e308bdda450@suse.de>
 <20191112052347.GA1197504@kroah.com>
 <20191112072926.isjxfa4ci6akhx56@pengutronix.de>
 <aff81b8e-f041-73a5-6a95-d308fa07842c@suse.de>
 <c8572f70-5550-8cee-4381-fd7de7ae5af0@baylibre.com>
 <CAMuHMdWOWWQoJh5=07VMRhtrFR_Gc_qNhjTV4tCsvwvMn0kYfA@mail.gmail.com>
 <a0a6d71f-4fb7-51ce-fe33-74f9e588b791@suse.de>
 <CAMuHMdU7EYHWRAR+s3ee4Wy6+6_MZON5xARszO7TDXZGyw8d5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU7EYHWRAR+s3ee4Wy6+6_MZON5xARszO7TDXZGyw8d5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Neil Armstrong <narmstrong@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-realtek-soc@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>, NXP Linux Team <linux-imx@nxp.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, boot-architecture@lists.linaro.org, Sascha Hauer <s.hauer@pengutr>
List-Id: linux-omap@vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org> [191115 15:51]:
> On Fri, Nov 15, 2019 at 1:01 PM Andreas Färber <afaerber@suse.de> wrote:
> > Am 15.11.19 um 09:58 schrieb Geert Uytterhoeven:
> > > We do our best to use it solely for detecting quirks in early SoC revisions.
> >
> > Got a pointer? I fail to immediately understand how sysfs would help
> > drivers (as opposed to userspace) detect quirks: Parsing strings back
> > doesn't sound efficient, and I don't see you exporting any custom APIs
> > in drivers/soc/renesas/renesas-soc.c?
> 
> We use soc_device_match(), inside kernel drivers.
> Exposure through sysfs is a side-effect of using soc_device_register(),
> and welcomed, as it allows the user to find out quickly which SoC and
> revision is being used.

For the omap variants too, we've so far gotten away with early SoC
detection for platform code, and then use soc_device_match() in few
cases for drivers at probe time if needed.

Regards,

Tony
