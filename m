From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/7] ARM: dts: omap: Add dts data for USB
Date: Fri, 15 Mar 2013 19:03:04 +0530
Message-ID: <51432310.7050201@ti.com>
References: <1362663320-23799-1-git-send-email-kishon@ti.com>
 <514316FA.1090002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <514316FA.1090002-l0cyMroinI0@public.gmane.org>
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
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 15 March 2013 06:11 PM, Benoit Cousson wrote:
> + Jon
>
> Hi Kishon,
>
> On 03/07/2013 02:35 PM, Kishon Vijay Abraham I wrote:
>> Hi Benoit,
>>
>> Here are the dt data patches to get usb device functional in OMAP platforms.
>>
>> All the patches deal with modifying arch/arm/boot except one which modifies
>> Documentation/../usb/omap-usb.txt
>>
>> Changes from v2:
>> * squashed the dt data for dwc3-omap with dwc3 core into a single patch.
>>
>> Changes from v1:
>> Patch *ARM: dts: omap: Add usb_otg and glue data* has some properties with
>> names that has "_". It's replaced with a "-" here.
>>
>> This patch is developed on Linux 3.9-rc1.
>
> The patches looks really good. I've just had to rebase on top of my HEAD due to some conflict with GPMC patch already applied.
>
> I cleaned as well some subject and changelog for consistency.

Ok. Thanks :-)

Regards
Kishon
