From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: How to handle named resources with DT?
Date: Wed, 10 Aug 2011 17:01:52 +0200
Message-ID: <4E429D60.2000100@ti.com>
References: <4E4166F0.9050401@ti.com>
	<CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
	<4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com>
	<20110809205723.GE11568@ponder.secretlab.ca>
	<4E41A1B9.1060400@ti.com>
	<20110809211747.GJ11568@ponder.secretlab.ca>
	<4E41AA43.1000506@ti.com>
	<20110809214905.GK11568@ponder.secretlab.ca>
	<4E41AC5C.20301@ti.com> <20110810015214.GD23511@yookeroo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110810015214.GD23511-787xzQ0H9iQXU02nzanrWNbf9cGiqdzd@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Cc: "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "G,
	Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 8/10/2011 3:52 AM, David Gibson wrote:
> On Tue, Aug 09, 2011 at 11:53:32PM +0200, Cousson, Benoit wrote:
>> On 8/9/2011 11:49 PM, Grant Likely wrote:
>>> On Tue, Aug 09, 2011 at 11:44:35PM +0200, Cousson, Benoit wrote:
>>>> On 8/9/2011 11:17 PM, Grant Likely wrote:
>>>>> On Tue, Aug 09, 2011 at 11:08:09PM +0200, Cousson, Benoit wrote:
>>>>>> On 8/9/2011 10:57 PM, Grant Likely wrote:
>>>>>>> On Tue, Aug 09, 2011 at 01:26:29PM -0500, Scott Wood wrote:
>>>>>>>> On 08/09/2011 12:47 PM, Cousson, Benoit wrote:
>>>>>>>>> On 8/9/2011 7:23 PM, Grant Likely wrote:
>>>>>>>>>> There is no analogous mechanism for _byname in the device tree.  The
>>>>>>>>>> DT binding for a device must explicitly state what order the register
>>>>>>>>>> ranges are in.  The driver will need to be adapted.
>>>>>>>>>
>>>>>>>>> That seems to be a small regression for my point of view. Relying on the
>>>>>>>>> order is not super safe. This is not very readable either. That's for
>>>>>>>>> that exact reason that we changed our drivers to use
>>>>>>>>> platform_get_resource_byname. That's probably the reason why that API is
>>>>>>>>> there as well.
>>>>>>>>> For the same IP, the number of entries can vary depending of the SoC
>>>>>>>>> revision.
>>>>>>>>> By using the _byname, we can check if the resource is there or not
>>>>>>>>> without having to care about the position.
>>>>>>>>
>>>>>>>> You could have a named u32 property that contains the reg index, e.g.:
>>>>>>>>
>>>>>>>> dev {
>>>>>>>> 	reg =<0x20000 0x200 0x24000 0x200>;
>>>>>>>> 	foo-reg =<0>;
>>>>>>>> 	bar-reg =<1>;
>>>>>>>> };
>>>>>>>
>>>>>>> That's a little nasty.  A reg-names = "foo", "bar"; would probably be
>>>>>>> better.
>>>>>>
>>>>>> Yep, I agree.
>>>>>>
>>>>>> And what about something like that?
>>>>>>    reg =<0x20000 0x200>, "foo",
>>>>>> 	<0x20000 0x200>, "bar" ;
>>>>>>
>>>>>> It is doable?
>>>>>
>>>>> Definitely not.  It would break all existing 'reg' parsing
>>>>> implementations quite badly.
>>>>
>>>> OK, so what about extending the reg attribute to be a reg node?
>>>>
>>>> dev {
>>>> 	reg {
>>>> 		name = "foo_wrapper";
>>>> 		start =<0x10000>;
>>>> 		end =<0x200>;
>>>> 	}
>>>> 	reg {
>>>> 		name = "foo";
>>>> 		start =<0x20000>;
>>>> 		end =<0x200>;
>>>> 	}
>>>> }
>>>>
>>>> A little bit more verbose, but at least we can add any attribute we want.
>>>
>>> That won't work either because that also breaks the existing 'reg'
>>> binding.  Anything you do will need to supplement the existing
>>> binding without changing it in an incompatible way.
>>
>> OK, but can we add a new attribute then? reg2, reg_ng, reg_plusplus,
>> reg_named...?
>
> He already suggested reg-names to be interpreted in parallel with the
> existing reg property.  The (serious) problem with replacing the reg
> property is that it will break all existing OSes (including old Linux
> versions) that don't understand the new property.

That's why I was proposing a new extended node for that. Legacy tag will 
still be there for legacy HW.

Adding reg-names is doable easily, but not super nice. And the same 
trick will be needed for IRQs and then DMAs (not yet in core DT anyway).
Having a more scalable mechanism to allow further improvement will be good.

> Of course, the problem with reg-names is that it will be ignored by
> older OSes, and so 'reg' must still be in the correct order.  In which
> case you could argue it's more sensible to just have a static place to
> name mapping in the Linux driver.
>
> In short, yes, named reg elements in the DT would be nice in theory,
> but I'm not convinced it's worth a DT flag day to accomplish it.

Sorry, but I'm not sure to understand the meaning of that last sentence.

Benoit
