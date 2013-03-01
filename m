From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 06/14] ARM: OMAP2+: Convert NAND to use
 gpmc_cs_program_settings()
Date: Fri, 1 Mar 2013 09:50:57 -0600
Message-ID: <5130CE61.6090007@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-7-git-send-email-jon-hunter@ti.com>
 <518397C60809E147AF5323E0420B992E3EA8F235@DBDE01.ent.ti.com>
 <512F7F79.4020900@ti.com>
 <518397C60809E147AF5323E0420B992E3EA90C46@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA90C46-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 02/28/2013 11:40 PM, Philip, Avinash wrote:
> On Thu, Feb 28, 2013 at 21:32:01, Hunter, Jon wrote:
>>
>> On 02/28/2013 04:38 AM, Philip, Avinash wrote:
>>> On Tue, Feb 26, 2013 at 23:00:33, Hunter, Jon wrote:
>>>> Convert the OMAP2+ NAND code to use the gpmc_cs_program_settings()
>>>> function for configuring the various GPMC options instead of directly
>>>> programming the CONFIG1 register.
>>>>
>>>> This moves the configuration of some GPMC options outside the
>>>> nand_gpmc_retime() because these options should only need to be set once
>>>> regardless of whether the gpmc timing is changing dynamically at runtime.
>>>> The programming of where the wait-pin is also moved slightly, but this
>>>> will not have any impact to existing devices as no boards are currently
>>>> setting the dev_ready variable.
>>>>
>>>> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>>  arch/arm/mach-omap2/gpmc-nand.c |   35 +++++++++++++++++++++++------------
>>>>  1 file changed, 23 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
>>>> index afc1e8c..4bdfea2 100644
>>>> --- a/arch/arm/mach-omap2/gpmc-nand.c
>>>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
>>>> @@ -43,6 +43,10 @@ static struct platform_device gpmc_nand_device = {
>>>>  	.resource	= gpmc_nand_resource,
>>>>  };
>>>>  
>>>> +static struct gpmc_settings nand_settings = {
>>>> +	.device_nand = true,
>>>> +};
>>>> +
>>>
>>> Is it possible to make it local variable?
>>> It would help GPMC to support NAND device on multiple chip select.
>>
>> Well gpmc_nand_init() will be called for each NAND device and so I don't
>> see why this would prevent supporting multiple NANDs on multiple
>> chip-selects.
> 
> Problem exactly lies here. Here platform device initialized as statically.
> So multiple requests will points to same platform device.
>
> Recently this issue raised in TI e2e forum and solution being proposed.
> Details can found from
> http://e2e.ti.com/support/arm/sitara_arm/f/791/p/246997/865379.aspx#865379
> 
> I doubt the same is the case for other GPMC client devices also.

This structure is only passed to gpmc_cs_program_settings() and not
stored in the platform device structure. So I don't think that this is
the same problem. Look at what the code is doing with the nand_settings
structure.

>> Once migration to device-tree is complete we could definitely make it
>> local as there will be no need for any static initialisations of the
>> structure as all fields would be read from device-tree.
>>
>> I can make it local now if that is preferred and seeing that will be the
>> direction once we have migrated to device-tree, is does make sense.
> 
> As far as I understood, here usage of local variable won't break anything?
> If that is the case, better solution would be usage of local variable.

It will not. So yes we can.

Jon
