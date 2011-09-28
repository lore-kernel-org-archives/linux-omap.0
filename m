From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
Date: Wed, 28 Sep 2011 10:06:17 +0200
Message-ID: <4E82D579.3080503@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110927150511.GM4289@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "patches@linaro.org" <patches@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 9/27/2011 5:05 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 08:18:04PM +0530, Rajendra Nayak wrote:
>> On Tuesday 27 September 2011 05:40 PM, Mark Brown wrote:
>>> On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:
>
>>>> +	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
>>>> +						 GFP_KERNEL);
>>>> +	if (!init_data)
>>>> +		return NULL; /* Out of memory? */
>
>>> This means that the init data will be kept around for the entire
>>> lifetime of the device rather than being discarded.
>
>> Wasn't it the same while this was passed around as platform_data?
>
> It was in the past but I remember fixing it at some point.  Perhaps I'm
> imagining things.
>
>>>> +	init_data->supply_regulator = (char *)of_get_property(dev->of_node,
>>>> +						"regulator-supplies", NULL);
>
>>> I'd expect that in the device tree world the supply regulator would
>>> reference the node for that regulator.
>
>> You mean using phandles? Thats what Grant proposed too but
>> I thought you instead had an inclination towards names? Or maybe
>> I misunderstood.
>
> They need both.  We need to reference the device that provides the
> supply and use a name to say which of the potentially multiple supplies
> on the consumer device is which.
>
>>> Hrm, I think loosing the signs here is bad karma - negative voltages do
>>> exist after all.
>
>> Oops.. they do? didn't know about that.
>
> Yup, ground is just a reference point.

Yep, we do have a negative charge pump to generate -1.9v from 3.8v to 
supply the audio power amplifier part in twl6040 for example.

Benoit
