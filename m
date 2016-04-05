From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH v5 1/6] pwms: pwm-ti*: Get the clock from the PWMSS
 (parent)
Date: Tue, 5 Apr 2016 06:25:56 -0500
Message-ID: <5703A0C4.6010406@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-2-git-send-email-fcooper@ti.com> <5703564C.7090700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <5703564C.7090700@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, "Kristo, Tero" <t-kristo@ti.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vigneshr@ti.com
List-Id: linux-omap@vger.kernel.org


On 04/05/2016 01:08 AM, Sekhar Nori wrote:
> On Tuesday 08 March 2016 06:53 AM, Franklin S Cooper Jr wrote:
> > The eCAP and ePWM doesn't have their own separate clocks. They simply
> > utilize the clock provided directly by the PWMSS. Therefore, they simply
> > need to grab a reference to their parent's clock.
> >
> > Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>
> So this assumes that eCAP and eHRPWM are always under the PWMSS
> umbrella. But on TI AM18x, thats not true. These IPs exist independently
> and receive functional clock from PLL sysclk outputs.
>
> > ---
> >  drivers/pwm/pwm-tiecap.c   | 2 +-
> >  drivers/pwm/pwm-tiehrpwm.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
> > index 616af76..9418159 100644
> > --- a/drivers/pwm/pwm-tiecap.c
> > +++ b/drivers/pwm/pwm-tiecap.c
> > @@ -212,7 +212,7 @@ static int ecap_pwm_probe(struct platform_device *pdev)
> >      if (!pc)
> >          return -ENOMEM;
> >  
> > -    clk = devm_clk_get(&pdev->dev, "fck");
> > +    clk = devm_clk_get(pdev->dev.parent, "fck");
>
> Even keeping the AM18x usecase aside, this seems to be pushing too much
> platform information into the driver. The "fck" is a valid connection id
> for the eCAP IP. Whether its valid for the parent device too is not
> something this driver should need to know.
>
> So it looks like what you need is for the clock hierarchy for the
> platform to have clocks for eHRPWM and eCAP derived out of PWMSS clock?

So I believe this is a question on if we want to hide the minor
delta between AM18 vs AM335x, AM437x and AM57x/DRA7 in the driver
or within the DT.

Note that handling this by defining new clocks in DT will then
result in older DTBs not working. I don't think its worth breaking
backwards compatibility for AM335x and AM437x DTBs for fixing support
for AM18 based SOCs. Especially since those SOCs haven't worked with
this driver for several years. By handling things within the driver rather
than DT we can atleast insure that we can get everything working while
avoiding breaking backwards compatibility.
>
> Thanks,
> Sekhar
>
