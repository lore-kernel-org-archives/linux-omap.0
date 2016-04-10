From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/6] pwms: pwm-ti*: Get the clock from the PWMSS
 (parent)
Date: Sun, 10 Apr 2016 20:51:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1604102048380.11457@utopia.booyaka.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com> <1457400224-24797-2-git-send-email-fcooper@ti.com> <5703564C.7090700@ti.com> <5703A0C4.6010406@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5703A0C4.6010406-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, "Kristo, Tero" <t-kristo-l0cyMroinI0@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi guys

On Tue, 5 Apr 2016, Franklin S Cooper Jr. wrote:

> On 04/05/2016 01:08 AM, Sekhar Nori wrote:
> > On Tuesday 08 March 2016 06:53 AM, Franklin S Cooper Jr wrote:
> > > The eCAP and ePWM doesn't have their own separate clocks. They simply
> > > utilize the clock provided directly by the PWMSS. Therefore, they simply
> > > need to grab a reference to their parent's clock.
> > >
> > > Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> >
> > So this assumes that eCAP and eHRPWM are always under the PWMSS
> > umbrella. But on TI AM18x, thats not true. These IPs exist independently
> > and receive functional clock from PLL sysclk outputs.
> >
> > > ---
> > >  drivers/pwm/pwm-tiecap.c   | 2 +-
> > >  drivers/pwm/pwm-tiehrpwm.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
> > > index 616af76..9418159 100644
> > > --- a/drivers/pwm/pwm-tiecap.c
> > > +++ b/drivers/pwm/pwm-tiecap.c
> > > @@ -212,7 +212,7 @@ static int ecap_pwm_probe(struct platform_device *pdev)
> > >      if (!pc)
> > >          return -ENOMEM;
> > >  
> > > -    clk = devm_clk_get(&pdev->dev, "fck");
> > > +    clk = devm_clk_get(pdev->dev.parent, "fck");
> >
> > Even keeping the AM18x usecase aside, this seems to be pushing too much
> > platform information into the driver. The "fck" is a valid connection id
> > for the eCAP IP. Whether its valid for the parent device too is not
> > something this driver should need to know.
> >
> > So it looks like what you need is for the clock hierarchy for the
> > platform to have clocks for eHRPWM and eCAP derived out of PWMSS clock?
> 
> So I believe this is a question on if we want to hide the minor
> delta between AM18 vs AM335x, AM437x and AM57x/DRA7 in the driver
> or within the DT.
> 
> Note that handling this by defining new clocks in DT will then
> result in older DTBs not working. I don't think its worth breaking
> backwards compatibility for AM335x and AM437x DTBs for fixing support
> for AM18 based SOCs. Especially since those SOCs haven't worked with
> this driver for several years. By handling things within the driver rather
> than DT we can atleast insure that we can get everything working while
> avoiding breaking backwards compatibility.

I agree with Sekhar that we shouldn't embed this parent clock quirk 
into the driver.  

Can you just define a new compatibility string such that the driver can be 
written with no embedded integration quirks?  Then add a workaround in the 
driver that will use pdev->dev.parent for the old (deprecated) 
compatibility string and log a warning to the kernel console that the DT 
needs to be updated.


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
