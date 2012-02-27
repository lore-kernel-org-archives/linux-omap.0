From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/2] Device tree support for TWL regulators
Date: Mon, 27 Feb 2012 15:21:26 +0100
Message-ID: <4F4B9166.7020909@ti.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
	<4F4B73C8.8070807@ti.com> <4F4B7798.6000300@ti.com>
	<20120227134112.GB3191@opensource.wolfsonmicro.com>
	<4F4B8A85.7060603@ti.com>
	<20120227140356.GF3191@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20120227140356.GF3191-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 2/27/2012 3:03 PM, Mark Brown wrote:
> On Mon, Feb 27, 2012 at 02:52:05PM +0100, Cousson, Benoit wrote:
>> On 2/27/2012 2:41 PM, Mark Brown wrote:
>>> On Mon, Feb 27, 2012 at 06:01:20PM +0530, Rajendra Nayak wrote:
>
>>> Please can you guys come up with a single unified series for this stuff
>>> - I'll hold off on applying anything to allow you to do this.
>
>> The issue is that the initial TWL regulator series from Rajendra
>> will depend on the twl core DT support I have that depends on the
>> irq_domain series from Grant...
>
> Really?  That's the first I've heard of any such dependency here.  Is it
> a build time dependency or is it just something that's required to make
> the code actually spring into life?  It looks like it's the latter but
> you're saying there's an actual dependency.

Mmm, it is written in Rajendra's changelog:

"-2- All common regulator nodes for twl4030 and twl6030 are
now defined in the twl4030.dtsi and twl6030.dtsi instead of
repeating the nodes in all board files, which also means
the patch ('arm/dts: twl: Pass regulator data from dt')
has a dependency with the series from Benoit which adds the
twl4030.dtsi and twl6030.dtsi files[2]."

The good point is that a missing or broken DTS will indeed not break the 
build, it will just not boot the platform properly. But that still an 
important dependency to me.

> There's also more than that, there's also at least Tero submitting some
> other stuff separately (and his stuff won't play with DT...) and I think
> Peter also.  It really fees like there's a bunch of people working on
> different things without talking to each other here.

That's the problem with MFD devices that are doing everything from audio 
to power including the coffee...

>> So I guess, it will be easy for us to split the regulator patches
>> from the DTS ones to have at least the driver changes merged by you.
>> Then Tony might be able to pull all the DTS in one series and thus
>> avoid the various merge conflict that will happen since most OMAP
>> drivers are hacking the same DTS files.
>
>> Does that make sense? Or do you think it will be even worst
>> separating the patches?
>
> Unless there's a compile time dependency I don't think we need to
> refactor anything here, what I'm seeing at the minute looks OK from a
> merge point of view except that there appears to be a lack of
> coordination between the various serieses.

Fair enough on that point. At least now we have all the stakeholders, so 
let's do some TI internal laundry.

Regards,
Benoit
