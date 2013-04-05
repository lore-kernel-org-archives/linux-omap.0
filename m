From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] ARM: OMAP4: clock: Add device tree support for AUXCLKs
Date: Fri, 5 Apr 2013 11:50:59 +0300
Message-ID: <515E9073.8050504@ti.com>
References: <1363703220-4777-2-git-send-email-rogerq@ti.com>
 <1364293408-20677-1-git-send-email-rogerq@ti.com> <515A958B.5080905@ti.com>
 <515E8F85.2060700@ti.com> <20130405084836.GA11331@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130405084836.GA11331@kahuna>
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
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/05/2013 11:48 AM, Nishanth Menon wrote:
> On 11:47-20130405, Roger Quadros wrote:
>> On 04/02/2013 11:23 AM, Roger Quadros wrote:
>>> + Paul
>>>
>>> On 03/26/2013 12:23 PM, Roger Quadros wrote:
>>>> Register a device tree clock provider for the clocks
>>>> on the OMAP4 SoC. Also provide the binding information.
>>>>
>>>> For now we only provide AUXCLKs.
>>
>> NOTE: this patch depends on
>> https://patchwork.kernel.org/patch/2312211/
>>
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>>  .../devicetree/bindings/clock/omap4-clock.txt      |   33 ++++++++++++++++
>>>>  arch/arm/boot/dts/omap4.dtsi                       |    5 ++
>>>>  arch/arm/mach-omap2/cclock44xx_data.c              |   41 ++++++++++++++++++++
>>>>  3 files changed, 79 insertions(+), 0 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/clock/omap4-clock.txt
> If we are doing this, we might as well do for all platforms(OMAP3-5,
> AM..) in an series, no?
> 
Yes, once we agree on the approach, I can write it for all OMAPs.

cheers,
-roger
