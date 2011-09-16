From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 06/11] DT: regulator: Helper routine to extract
	fixed_voltage_config
Date: Fri, 16 Sep 2011 14:56:42 +0530
Message-ID: <4E731652.7050106@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
	<1316085727-15023-2-git-send-email-rnayak@ti.com>
	<1316085727-15023-3-git-send-email-rnayak@ti.com>
	<1316085727-15023-4-git-send-email-rnayak@ti.com>
	<1316085727-15023-5-git-send-email-rnayak@ti.com>
	<1316085727-15023-6-git-send-email-rnayak@ti.com>
	<1316085727-15023-7-git-send-email-rnayak@ti.com>
	<20110915135051.GL7988@opensource.wolfsonmicro.com>
	<4E72F875.4090001@ti.com>
	<20110916090123.GE22062@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110916090123.GE22062-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 16 September 2011 02:31 PM, Mark Brown wrote:
> On Fri, Sep 16, 2011 at 12:49:17PM +0530, Rajendra Nayak wrote:
>> On Thursday 15 September 2011 07:20 PM, Mark Brown wrote:
>>> On Thu, Sep 15, 2011 at 04:52:02PM +0530, Rajendra Nayak wrote:
>
>>>> +# For fixed voltage regulators
>>>> +- supply-name: Name of the regulator supply
>>>> +- microvolts: Output voltage of regulator
>>>> +- gpio: gpio to use for enable control
>>>> +- startup-delay: startup time in microseconds
>>>> +- enable-high: Polarity of enable GPIO, 1 = Active High, 0 = Active low
>>>> +- enabled-at-boot: 1 = yes, 0 = no
>
>>> Much of this is specific to the Linux fixed voltage regulator driver
>>> rather than a generic regulator with a fixed voltage.
>
>> So how should these non-generic things be handled through device
>> tree? Should they never be part of dt or should the bindings just be
>> defined such that its clear they are linux specific?
>
> Having them be part of the fixed voltage regulator bindings would be
> fine, the problem is that you're adding this in framework code not in a
> driver.

agree, will make the bindings fixed voltage regulator specific.
