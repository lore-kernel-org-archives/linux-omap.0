From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V4] ARM: dts: add minimal DT support for DevKit8000.
Date: Thu, 7 Mar 2013 07:51:30 +0100
Message-ID: <513838F2.60101@ti.com>
References: <F3DBB1B3EF102E4994C89758CFCA32412CC4E9@DBDE01.ent.ti.com>
 <CABYxbz5GyxYaHANgdpwBNaaR6tnu=6LJuUNSvL7DEzU=4CPHcA@mail.gmail.com>
 <F3DBB1B3EF102E4994C89758CFCA32412CC74F@DBDE01.ent.ti.com>
 <CABYxbz62JrMB95p5i9iu2G=B4ETXLrYbLsyFEFR5F+WVD6YNnQ@mail.gmail.com>
 <20130306175313.GQ11806@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130306175313.GQ11806-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Weber <thomas-xePHB1Atl/Dsq35pWSNszA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 03/06/2013 06:53 PM, Tony Lindgren wrote:
> * Anil Kumar <anilk4.v-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [130305 18:40]:
>> Hi Tony,
>>
>>>> From: linux-arm-kernel [mailto:linux-arm-kernel-
>>>> bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Anil Kumar
>>>> Sent: Wednesday, February 27, 2013 8:03 AM
>>>> To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>>>> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>>> Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org; Cousson, Benoit; Tony Lindgren; Grant
>>>> Likely; Anil Kumar; thomas-xePHB1Atl/Dsq35pWSNszA@public.gmane.org
>>>> Subject: Re: FW: [PATCH V4] ARM: dts: add minimal DT support for
>>>> DevKit8000.
>>>>
>>>> Hi,
>>>>>
>>>>> DevKit8000 is a beagle board clone from Timll, sold by
>>>>> armkits.com. The DevKit8000 has RS232 serial port, LCD, DVI-D,
>>>>> S-Video, Ethernet, SD/MMC, keyboard, camera, SPI, I2C, USB and
>>>>> JTAG interface.
>>>>>
>>>>> This patch adds the basic DT support for devkit8000. At this time,
>>>> Information
>>>>> of twl4030 (PMIC), MMC1, I2C1 and leds are added.
>>>>>
>>>>> Signed-off-by: Anil Kumar <anilk4.v-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>> Tested-by: Thomas Weber <thomas-xePHB1Atl/Dsq35pWSNszA@public.gmane.org>
>>>>
>>>> Gentle Ping. As there are no review comments on this patch,
>>>> Could you please pull this patch ?
>>
>> Gentle Ping.
>>
>> This patch also got Reviewed-by: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> and as patch "ARM: dts: omap3-devkit8000: Enable audio support"  has already got
>> "Acked-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>" but it is on the
>> top of this patch.
>> So, Could you please pull this patch in one of your omap branch? or
>> you want me to
>> do rebase this patch on top of v3.9-rc1 ?
> 
> Let's wait for Benoit to queue it as he has a bunch of .dts changes already
> applied. Too bad we missed v3.9 merge window for those, but hopefully
> we can get them queued early for v3.10.

Yep, sorry for having missed 3.9, I was a little bit sick at the wrong
moment :-(

I'm starting queuing the pending patches, and should have enough to push
to you just after Linaro Connect.

Regards,
Benoit
