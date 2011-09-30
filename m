From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
Date: Fri, 30 Sep 2011 13:35:40 +0200
Message-ID: <4E85A98C.9060702@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
	<4E854532.6080605@ti.com>
	<20110930102849.GA4195@opensource.wolfsonmicro.com>
	<20110930104820.GE2085@sirena.org.uk> <4E85A34E.9070203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E85A34E.9070203@ti.com>
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

On 9/30/2011 1:09 PM, Nayak, Rajendra wrote:
> On Friday 30 September 2011 04:18 PM, Mark Brown wrote:
>> On Fri, Sep 30, 2011 at 11:28:49AM +0100, Mark Brown wrote:
>>> On Fri, Sep 30, 2011 at 09:57:30AM +0530, Rajendra Nayak wrote:
>>
>>>>>> +  init_data->supply_regulator = (char *)of_get_property(dev->of_node,
>>>>>> +                                          "regulator-supplies", NULL);
>>
>>>> Mark, I still seem to be a little confused with this one as to why
>>>> we would need a phandle *and* a supply-name to reference a parent
>>>> regulator/supply.
>>>> The phandle would point to a regulator dt node and that node internally
>>>> would have just one name associated with it.
>>
>>> To repeat: the supply name is for the consumer.  It is needed so that
>>> the consumer can tell which supply is provided by which regulator.
>>> Almost all devices have more than one supply and if the device does
>>> anything more complicated than just turning on all the supplies when the
>>> device is active it's going to need to figure out which supply is which.
>>
>> Hang on, I now have no idea what this is supposed to be doing.  Later on
>> in the series you had examples in your commit logs with perfectly
>> sensible bindings for supplies:
>>
>>                   vmmc-supply =<&regulator1>;
>>                   vpll-supply =<&regulator1>;
>>
>> which have both a unique name and a direct reference to the supplying
>> regulator.  What are these "regulator-supplies" properties supposed to
>> be?
>
> :-), yes, I was confused for a while as well after reading your response.
>
> The "regulator-supplies" is used to specific the regulator *parent*.
> Same as what was earlier passed by using the
> "supply_regulator" field of regulator_init_data structure.
> Grant wanted the bindings to support specifying multiple parents
> and hence I was thinking of either a list of names *or*
> a list of phandles to specify multiple parents to a regulator.

I'm confused too now :-)

You can not have multiple to one kind of connection from a power supply 
to a single power rail of an IP (vmmc, vpll...).
So I do not see the need for more any other binding that the one you did:
	vmmc-supply = <&regulator1>;

That kind of binding does not really exist in the real world:

	vmmc-supply = <&regulator1 &regulator2>;

At least not without a power switch in between.

Regards,
Benoit
