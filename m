From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/2] Device tree support for TWL regulators
Date: Mon, 27 Feb 2012 23:24:14 +0100
Message-ID: <4F4C028E.2000405@ti.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
	<4F4B73C8.8070807@ti.com> <4F4B7798.6000300@ti.com>
	<20120227134112.GB3191@opensource.wolfsonmicro.com>
	<4F4B8A85.7060603@ti.com>
	<CACxGe6vU2dSpRrqd2y=ssgVsWuwpuvFtja9YcUAQA_ETWcwCYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CACxGe6vU2dSpRrqd2y=ssgVsWuwpuvFtja9YcUAQA_ETWcwCYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 2/27/2012 11:17 PM, Grant Likely wrote:
> On Mon, Feb 27, 2012 at 6:52 AM, Cousson, Benoit<b-cousson-l0cyMroinI0@public.gmane.org>  wrote:
>> Hi Mark,
>>
>>
>> On 2/27/2012 2:41 PM, Mark Brown wrote:
>>>
>>> On Mon, Feb 27, 2012 at 06:01:20PM +0530, Rajendra Nayak wrote:
>>>
>>>> Depending on what order Mark happens to pull them in, I am fine
>>>> re-sending adding support for the 2 twl6030 fixed regulators.
>>>
>>>
>>> Please can you guys come up with a single unified series for this stuff
>>> - I'll hold off on applying anything to allow you to do this.
>>
>>
>> The issue is that the initial TWL regulator series from Rajendra will depend
>> on the twl core DT support I have that depends on the irq_domain series from
>> Grant...
>
> If it depends on the irqdomain tree, then just merge that tree into
> yours.  That tree is stable now for exactly that reason.  You can rely
> on it.

I've just posted a pull request [1] to Tony that will merge your series 
into an OMAP DT branch to be a base for further OMAP DT series.

Regards,
Benoit


[1] http://www.spinics.net/lists/linux-omap/msg65346.html
