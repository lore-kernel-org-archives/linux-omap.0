From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Thu, 6 Dec 2012 10:22:30 -0600
Message-ID: <50C0C646.9000802@ti.com>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com>
 <1354734571-10774-6-git-send-email-zonque@gmail.com>
 <20121205222232.67B2B3E0E22@localhost> <50BFCBCC.6030706@ti.com>
 <20121205232426.BAD573E0E22@localhost> <20121206000302.GM21682@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121206000302.GM21682-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: x0148406-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 12/05/2012 06:03 PM, Tony Lindgren wrote:
> * Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> [121205 15:26]:
>> On Wed, 5 Dec 2012 16:33:48 -0600, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org> wrote:
>>> On 12/05/2012 04:22 PM, Grant Likely wrote:
>>>>
>>>> Please, be specific. Use something like "ti,am3340-gpmc" or
>>>> "ti,omap3430-gpmc". The compatible property is a list so that new
>>>> devices can claim compatibility with old. Compatible strings that are
>>>> overly generic are a pet-peave of mine.
>>>
>>> We aim to use the binding for omap2,3,4,5 as well as the am33xx devices
>>> (which are omap based). Would it be sufficient to have "ti,omap2-gpmc"
>>> implying all omap2+ based devices or should we have a compatible string
>>> for each device supported?
>>
>> Are they each register-level compatible with one another?
>>
>> The general recommended approach here is to make subsequent silicon
>> claim compatibility with the first compatible implementation.
>>
>> So, for an am3358 board:
>> 	compatible = "ti,am3358-gpmc", "ti,omap2420-gpmc";
>>
>> Essentially, what this means is that "ti,omap2420-gpmc" is the generic
>> value instead of "omap2-gpmc". The reason for this is so that the value
>> is anchored against a specific implementation, and not against something
>> completely imaginary or idealized. If a newer version isn't quite
>> compatible with the omap2420-gpmc, then it can drop the compatible claim
>> and the driver really should be told about the new device.
> 
> The compatible property can also be used to figure out which ones
> need the workarounds in patch #4 of this series for the DT case.
> So we should be specific with the compatible.

We should not merged patch #4. Daniel included this here because he is
using this on the current mainline, however, this is not needed for
linux-next and so we should drop it.

Cheers
Jon
