From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] base: soc: Export soc_device_to_device() helper
Date: Tue, 12 Nov 2019 06:23:47 +0100
Message-ID: <20191112052347.GA1197504@kroah.com>
References: <20191103013645.9856-3-afaerber@suse.de>
 <20191111045609.7026-1-afaerber@suse.de>
 <20191111052741.GB3176397@kroah.com>
 <586fa37c-6292-aca4-fa7c-73064858afaf@suse.de>
 <20191111064040.GA3502217@kroah.com>
 <a88442df-dc6b-07e5-8dee-9e308bdda450@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <a88442df-dc6b-07e5-8dee-9e308bdda450@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-realtek-soc@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Fabio Estevam <festevam@gmail.com>, Kevin Hilman <khilman@baylibre.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>, NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, linux-amlogic@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Pengutronix Kernel Team <kernel@pengutr>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 11, 2019 at 09:10:41PM +0100, Andreas F=E4rber wrote:
> Am 11.11.19 um 07:40 schrieb Greg Kroah-Hartman:
> > On Mon, Nov 11, 2019 at 06:42:05AM +0100, Andreas F=E4rber wrote:
> >> Hi Greg,
> >>
> >> Am 11.11.19 um 06:27 schrieb Greg Kroah-Hartman:
> >>> On Mon, Nov 11, 2019 at 05:56:09AM +0100, Andreas F=E4rber wrote:
> >>>> Use of soc_device_to_device() in driver modules causes a build failu=
re.
> >>>> Given that the helper is nicely documented in include/linux/sys_soc.=
h,
> >>>> let's export it as GPL symbol.
> >>>
> >>> I thought we were fixing the soc drivers to not need this.  What
> >>> happened to that effort?  I thought I had patches in my tree (or
> >>> someone's tree) that did some of this work already, such that this
> >>> symbol isn't needed anymore.
> >>
> >> I do still see this function used in next-20191108 in drivers/soc/.
> >>
> >> I'll be happy to adjust my RFC driver if someone points me to how!
> > =

> > Look at c31e73121f4c ("base: soc: Handle custom soc information sysfs
> > entries") for how you can just use the default attributes for the soc to
> > create the needed sysfs files, instead of having to do it "by hand"
> > which is racy and incorrect.
> =

> Unrelated.
> =

> >> Given the current struct layout, a type cast might work (but ugly).
> >> Or if we stay with my current RFC driver design, we could use the
> >> platform_device instead of the soc_device (which would clutter the
> >> screen more than "soc soc0:") or resort to pr_info() w/o device.
> > =

> > Ick, no, don't cast blindly.  What do you need the pointer for?  Is this
> > for in-tree code?
> =

> No, an RFC patchset: https://patchwork.kernel.org/cover/11224261/
> =

> As I indicated above, I used it for a dev_info(), which I can easily
> avoid by using pr_info() instead:
> =

> diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c
> index e5078c6731fd..f9380e831659 100644
> --- a/drivers/soc/realtek/chip.c
> +++ b/drivers/soc/realtek/chip.c
> @@ -178,8 +178,7 @@ static int rtd_soc_probe(struct platform_device *pdev)
> =

>         platform_set_drvdata(pdev, soc_dev);
> =

> -       dev_info(soc_device_to_device(soc_dev),
> -               "%s %s (0x%08x) rev %s (0x%08x) detected\n",
> +       pr_info("%s %s (0x%08x) rev %s (0x%08x) detected\n",
>                 soc_dev_attr->family, soc_dev_attr->soc_id, chip_id,
>                 soc_dev_attr->revision, chip_rev);

First off, the driver should not be spitting out noise for when all goes
well like this :)

Anyway, just use the pdev pointer here, not the soc dev as that is NOT a
pointer you have control over (as is evident by the fact that you need
this call to try to get it.)

I'll look at your other instances later when I've had my coffee...

thanks,

greg k-h
