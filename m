From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 3/3] OMAP: hwmod: Force a softreset during _setup
Date: Thu, 19 Aug 2010 17:27:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E82ACD94@dbde02.ent.ti.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
 <1280959968-23933-4-git-send-email-b-cousson@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E81E9434@dbde02.ent.ti.com>
 <4C6BF591.1010007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36260 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab0HSL5M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 07:57:12 -0400
In-Reply-To: <4C6BF591.1010007@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Wednesday, August 18, 2010 8:31 PM
> To: Basak, Partha
> Cc: Nayak, Rajendra; Shilimkar, Santosh; linux-omap@vger.kernel.org;
> khilman@deeprootsystems.com; paul@pwsan.com
> Subject: Re: [PATCH 3/3] OMAP: hwmod: Force a softreset during _setup
> 
> Hi Partha,
> 
> On 8/17/2010 2:46 PM, Basak, Partha wrote:
> >
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Cousson, Benoit
> >> Sent: Thursday, August 05, 2010 3:43 AM
> >>
> >> Force the softreset of every IPs during the _setup phase.
> >> IPs that cannot support softreset or that should not
> >> be reset must set the HWMOD_INIT_NO_RESET flag in the
> >> hwmod struct.
> >>
> >> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >> Cc: Paul Walmsley<paul@pwsan.com>
> >> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> >> ---
> >>   arch/arm/mach-omap2/omap_hwmod.c |   17 ++++++++---------
> >>   1 files changed, 8 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-
> >> omap2/omap_hwmod.c
> >> index 53b08e3..91ad9c6 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> >> @@ -856,8 +856,8 @@ static int _reset(struct omap_hwmod *oh)
> >>
> >>   	/* clocks must be on for this operation */
> >>   	if (oh->_state != _HWMOD_STATE_ENABLED) {
> >> -		WARN(1, "omap_hwmod: %s: reset can only be entered from "
> >> -		     "enabled state\n", oh->name);
> >> +		pr_warning("omap_hwmod: %s: reset can only be entered from "
> >> +			   "enabled state\n", oh->name);
> >>   		return -EINVAL;
> >>   	}
> >>
> >> @@ -874,8 +874,8 @@ static int _reset(struct omap_hwmod *oh)
> >>   			  MAX_MODULE_RESET_WAIT, c);
> >>
> >>   	if (c == MAX_MODULE_RESET_WAIT)
> >> -		WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
> >> -		     oh->name, MAX_MODULE_RESET_WAIT);
> >> +		pr_warning("omap_hwmod: %s: failed to reset in %d usec\n",
> >> +			   oh->name, MAX_MODULE_RESET_WAIT);
> >
> > http://focus.ti.com/pdfs/wtbu/SWPU177B_FinalEPDF_12_04_2009.pdf
> >
> > This is leading to the above warning for DSS on OMAP3430/3630. Referring
> to the reference manual (7.5.1 Display Subsystem Reset), successful reset
> of DSS would need PRCM.CM_FCLKEN_DSS[2] EN_TV bit set to 1. For DSS, even
> though TV clock is an optional clock, this is mandatory for successful DSS
> reset. We could ignore this warning, or possibly WA it.
> > One way could be:
> >
> > 1. In the database, have HWMOD_INIT_NO_RESET flag set so that _setup()
> skips reset.
> >
> > 2. After omap device build of DSS is done, lookup the opt-clock and
> enable it (using clock framework).
> >
>>
> > 4. Then do DSS reset again calling omap_device_reset().
> >
> > All IPs that potentially have any special soft-reset sequence will need
> customized handling. Should we keep the framework light and handle such
> special cases in the drivers? In that case, the framework need not throw
> up a warning. Please comment.
> 
> If the softreset is not mandatory for an IP like DSS, you just have to
> set this HWMOD_INIT_NO_RESET flag.
> There is no need to use the softreset for every IP, the PRCM already
> resets every IPs each time the power domain is powered on.
> softreset is useful if you need to recover from an HW error.
> 

I agree, however without doing soft-reset, we have observed DSI malfunction. Senthil can provide more details. As DSS needs TV_clk for successful reset, I doubt whether PRCM can reset DSS once we merely turn on the DSS power domain.
So, it really depends on the IP in question. If it is necessary, we will do a omap_device_reset()in the driver. Correct?

> Regards,
> Benoit
