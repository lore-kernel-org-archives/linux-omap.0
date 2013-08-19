From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/2] rtc: omap: update of_device_id to reflect
 latest ip revisions
Date: Mon, 19 Aug 2013 15:45:37 +0100
Message-ID: <20130819144537.GQ3719@e106331-lin.cambridge.arm.com>
References: <1376653017-21935-1-git-send-email-gururaja.hebbar@ti.com>
 <1376653017-21935-2-git-send-email-gururaja.hebbar@ti.com>
 <520E341D.4080206@baylibre.com>
 <20130816172022.GA3719@e106331-lin.cambridge.arm.com>
 <520E6B9E.5080706@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <520E6B9E.5080706@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "khilman@linaro.org" <khilman@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "rob@landley.net" <rob@landley.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "sudhakar.raj@ti.com" <sudhakar.raj@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 16, 2013 at 07:12:46PM +0100, Benoit Cousson wrote:
> Hi Mark,
> 
> On 16/08/2013 19:20, Mark Rutland wrote:
> > Hi Benoit,
> >
> > On Fri, Aug 16, 2013 at 03:15:57PM +0100, Benoit Cousson wrote:
> >> Hi Gururaja,
> >>
> >> On 16/08/2013 13:36, Hebbar, Gururaja wrote:
> >>> The syntax of compatible property in DT is to mention the Most specific
> >>> match to most generic match.
> >>>
> >>> Since AM335x is the platform with latest IP revision, add it 1st in
> >>> the device id table.
> >>
> >> I don't understand why? The order should not matter at all.
> >>
> >> I've tried to follow the thread you had with Mark on the v2, but AFAIK,
> >> you've never answered to his latest question.
> >>
> >> Moreover, checking the differences between the Davinci and the am3352
> >> RTC IP, I would not claim that both are compatible.
> >>
> >> Sure you can use the am3352 with the Davinci driver, but you will lose
> >> the wakeup functionality without even being notify about that.
> >
> > Could you describe the wakeup functionality, and how it differs between
> > the am3352-rtc and the da830-rtc?
> 
> AFAIK, da830-rtc does not have that functionality at all. This is 
> something that was added to the am3352-rtc.

Ok. So the am3352-rtc can be driven with the full functionality of the
da830-rtc (ie. it's compatible with the da830-rtc programming model), or
it can be driven as an am3352-rtc, for the OS to gain wakeup
functionality in addition to the da830-rtc features. :)

> 
> > As I understand it, the am3352 functionality is a superset of the da830
> > functionality. You can use the old driver, and get some functionality,
> > or use the new driver and get it all.
> 
> Mmm, what your are saying now seems to make sense to me as well. So I'm 
> even more confused :-)

I'll convince you yet :)

> 
> > That means that am3352-rtc is compatible with da830. As long as the
> > kernel first checks for am3352-rtc, there will be *no* loss of
> > functionality. All this does is enable older kernels to use the hardware
> > in some fashion, and given the older kernel didn't have support for the
> > am3352-rtc features, this is a *gain* in functionality, not a loss.
> >
> >>
> >> For my point of view, compatible mean that the HW will still be fully
> >> functional with both versions of the driver, which is not the case here.
> >
> > What? A driver for any entry in the compatible list should be able to
> > drive the hardware to *some* level of functionality. We list from
> > most-specific to most-general to allow a graceful degradation from fully
> > supported to bare minimum functionality.
> 
> OK, but where is it written in the DT spec that this is what the 
> compatible is supposed to mean?
> 
> I'm quoting it again:
> "
> The compatible property value consists of one or more strings that 
> define the specific programming model for the device. This list of 
> strings should be used by a client program for device driver selection. 
> The property value consists of a concatenated list of null terminated
> strings, from most specific to most general. They allow a device to 
> express its compatibility with a family of similar devices, potentially 
> allowing a single device driver to match against several devices.
> "
> 
> The graceful degradation or the loss of functionality is not something 
> that I really understand in that text.

I think it's implicit in the example that follows, where a failure to
match against a specific device results in the OS falling back to a
"more general" device. The "more general" device may not have all the
features of a more specific device (conversely, the more general device
may have more optional features that a more specific device is known not
to implement).

> 
> Anyway, I'm probably too tired... I'll go back home, and think about 
> that after the week-end.

Ok, let me know what you think. :)

Thanks,
Mark.
