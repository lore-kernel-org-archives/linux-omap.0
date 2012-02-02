From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] arm/dts: OMAP3: Add omap3evm and am335xevm support
Date: Thu, 2 Feb 2012 10:43:39 +0100
Message-ID: <4F2A5ACB.5070002@ti.com>
References: <1328077620-22411-1-git-send-email-hvaibhav@ti.com>
 <20120202045629.GJ15343@ponder.secretlab.ca>
 <79CD15C6BA57404B839C016229A409A8317BCD98@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317BCD98-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Vaibhav,

On 2/2/2012 10:34 AM, Hiremath, Vaibhav wrote:
> On Thu, Feb 02, 2012 at 10:26:29, Grant Likely wrote:
>> On Wed, Feb 01, 2012 at 11:57:00AM +0530, Vaibhav Hiremath wrote:
>>> TI's OMAP3EVM and AM335xEVM are software development boards
>>> available for OMAP35x(AM/DM37x) and AM335x devices respectively;
>>> and these devices are considered under omap3 family.
>>>
>>> Signed-off-by: Vaibhav Hiremath<hvaibhav-l0cyMroinI0@public.gmane.org>
>>> Cc: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
>>> Cc: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>>> Cc: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>
>> Applied, thanks.
>>
>
> Benoit and/or Grant,
>
> Can you also pull-in/merge all other patches which I had submitted recently?

I can pull them all through Tony's tree, but I still need Grant's 
Acked-by. So far, I have these ones ready for pull:
  arm/dts: Add support for TI OMAP3 EVM board.
  arm:omap2:board-generic: Add DT support for AM33xx devices
  arm/dts: Add support for TI AM335x EVM board

It looks like these ones do not have the Ack:
  arm/dts: omap3-evm: Add i2c and twl4030 support
  arm/dts: Add support for TI AM3517/05 EVM board


Regards,
Benoit


>
> arm/dts: omap3-evm: Add i2c and twl4030 support
> arm/dts: Add support for TI AM3517/05 EVM board
> arm:omap2:board-generic: Add DT support for AM33xx devices
> arm/dts: Add support for TI AM335x EVM board
>
> Thanks,
> Vaibhav
>> g.
>>
>>> ---
>>>   .../devicetree/bindings/arm/omap/omap.txt          |    6 ++++++
>>>   1 files changed, 6 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
>>> index dbdab40..ce78498 100644
>>> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
>>> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
>>> @@ -41,3 +41,9 @@ Boards:
>>>
>>>   - OMAP4 PandaBoard : Low cost community board
>>>     compatible = "ti,omap4-panda", "ti,omap4430"
>>> +
>>> +- OMAP3 EVM : Software Developement Board for OMAP35x, AM/DM37x
>>> +  compatible = "ti,omap3-evm", "ti,omap3"
>>> +
>>> +- AM335X EVM : Software Developement Board for AM335x
>>> +  compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
>>> --
>>> 1.7.0.4
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
