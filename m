From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Sense of soc bus? (was: [PATCH] base: soc: Export
 soc_device_to_device() helper)
Date: Fri, 15 Nov 2019 09:58:18 +0100
Message-ID: <CAMuHMdWOWWQoJh5=07VMRhtrFR_Gc_qNhjTV4tCsvwvMn0kYfA@mail.gmail.com>
References: <20191103013645.9856-3-afaerber@suse.de> <20191111045609.7026-1-afaerber@suse.de>
 <20191111052741.GB3176397@kroah.com> <586fa37c-6292-aca4-fa7c-73064858afaf@suse.de>
 <20191111064040.GA3502217@kroah.com> <a88442df-dc6b-07e5-8dee-9e308bdda450@suse.de>
 <20191112052347.GA1197504@kroah.com> <20191112072926.isjxfa4ci6akhx56@pengutronix.de>
 <aff81b8e-f041-73a5-6a95-d308fa07842c@suse.de> <c8572f70-5550-8cee-4381-fd7de7ae5af0@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c8572f70-5550-8cee-4381-fd7de7ae5af0@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-realtek-soc@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>, NXP Linux Team <linux-imx@nxp.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, boot-architecture@lists.linaro.org, Sascha Hauer <s.hauer@pengutronix.d>
List-Id: linux-omap@vger.kernel.org

Hi Neil,

On Fri, Nov 15, 2019 at 9:52 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 12/11/2019 11:47, Andreas Färber wrote:
> > Am 12.11.19 um 08:29 schrieb Uwe Kleine-König:
> >> On Tue, Nov 12, 2019 at 06:23:47AM +0100, Greg Kroah-Hartman wrote:
> >>> On Mon, Nov 11, 2019 at 09:10:41PM +0100, Andreas Färber wrote:
> >>>> Am 11.11.19 um 07:40 schrieb Greg Kroah-Hartman:
> >>>>> On Mon, Nov 11, 2019 at 06:42:05AM +0100, Andreas Färber wrote:
> >>>>>> Am 11.11.19 um 06:27 schrieb Greg Kroah-Hartman:
> >>>>>>> On Mon, Nov 11, 2019 at 05:56:09AM +0100, Andreas Färber wrote:
> >>>>>>>> Use of soc_device_to_device() in driver modules causes a build failure.
> >>>>>>>> Given that the helper is nicely documented in include/linux/sys_soc.h,
> >>>>>>>> let's export it as GPL symbol.
> >>>>>>>
> >>>>>>> I thought we were fixing the soc drivers to not need this.  What
> >>>>>>> happened to that effort?  I thought I had patches in my tree (or
> >>>>>>> someone's tree) that did some of this work already, such that this
> >>>>>>> symbol isn't needed anymore.
> >>>>>>
> >>>>>> I do still see this function used in next-20191108 in drivers/soc/.
> >>>>>>
> >>>>>> I'll be happy to adjust my RFC driver if someone points me to how!
> >>>>>
> >>>>> Look at c31e73121f4c ("base: soc: Handle custom soc information sysfs
> >>>>> entries") for how you can just use the default attributes for the soc to
> >>>>> create the needed sysfs files, instead of having to do it "by hand"
> >>>>> which is racy and incorrect.
> >>>>
> >>>> Unrelated.
> >>>>
> >>>>>> Given the current struct layout, a type cast might work (but ugly).
> >>>>>> Or if we stay with my current RFC driver design, we could use the
> >>>>>> platform_device instead of the soc_device (which would clutter the
> >>>>>> screen more than "soc soc0:") or resort to pr_info() w/o device.
> >>>>>
> >>>>> Ick, no, don't cast blindly.  What do you need the pointer for?  Is this
> >>>>> for in-tree code?
> >>>>
> >>>> No, an RFC patchset: https://patchwork.kernel.org/cover/11224261/
> >>>>
> >>>> As I indicated above, I used it for a dev_info(), which I can easily
> >>>> avoid by using pr_info() instead:
> >>>>
> >>>> diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c
> >>>> index e5078c6731fd..f9380e831659 100644
> >>>> --- a/drivers/soc/realtek/chip.c
> >>>> +++ b/drivers/soc/realtek/chip.c
> >>>> @@ -178,8 +178,7 @@ static int rtd_soc_probe(struct platform_device *pdev)
> >>>>
> >>>>         platform_set_drvdata(pdev, soc_dev);
> >>>>
> >>>> -       dev_info(soc_device_to_device(soc_dev),
> >>>> -               "%s %s (0x%08x) rev %s (0x%08x) detected\n",
> >>>> +       pr_info("%s %s (0x%08x) rev %s (0x%08x) detected\n",
> >>>>                 soc_dev_attr->family, soc_dev_attr->soc_id, chip_id,
> >>>>                 soc_dev_attr->revision, chip_rev);
> >>>
> >>> First off, the driver should not be spitting out noise for when all goes
> >>> well like this :)
> >>
> >> I didn't follow the discussion closely, but I think I want to object
> >> here a bit. While I agree that each driver emitting some stuff to the
> >> log buffer is hardly helpful, seeing the exact SoC details is indeed
> >> useful at times. With my Debian kernel team member hat on, I'd say
> >> keep this information. This way the SoC details make it into kernel bug
> >> reports without effort on our side.
> >
> > Seconded. For example, RTD1295 will support LSADC only from revision B00
> > on (and it's not the first time I'm seeing such things in the industry).
> > So if a user complains, it will be helpful to see that information.
> >
> > Referencing your Amlogic review, with all due respect for its authors,
> > the common framework here just lets that information evaporate into the
> > deeps of sysfs.
>
> Hopefully we never had the case where needed to use the soc info in drivers,
> but now we have one and having such infrastructure already in-place will help.
>
> Renesas platforms makes a extensive usage of the soc info infrastructure to
> figure out plenty of HW parameters at runtime and lower their DT changes.

We do our best to use it solely for detecting quirks in early SoC revisions.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
