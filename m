From: Jeroen Hofstee <jeroen@myspectrum.nl>
Subject: Re: [PATCH] ARM: dts: AM35xx: fix system control module clocks
Date: Fri, 05 Jun 2015 10:04:10 +0200
Message-ID: <557157FA.7080305@myspectrum.nl>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
 <1433172627-28052-1-git-send-email-t-kristo@ti.com>
 <556C8ED5.5050000@myspectrum.nl> <20150601173126.GY30984@atomide.com>
 <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
 <5571576E.6020207@myspectrum.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5571576E.6020207@myspectrum.nl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jeroen Hofstee <linux-arm@myspectrum.nl>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


On 05-06-15 10:01, Jeroen Hofstee wrote:
> Hello Paul,
>
> On 01-06-15 19:44, Paul Walmsley wrote:
>> The best way to make this work IMHO would be for us not to accept any 
>> new
>> feature addition patches as long as there are warnings reported in the
>> test results.  The only real exception that I would foresee is if those
>> warnings are due to something outside of our control, e.g., a crappy
>> bootloader, as I suspect the USB_OTG initiator warnings are for the
>> CM-T3517.
>>
>
> I doubt this is related to the bootloader. I have the suspicion that 
> is actually
> a bug in linux but only triggered depending on whether the ROMcode setup
> the USB OTG or not. Here is some data to backup my statement:
>
> Linux booting without USB_OTG error trap
> md 480022F0 1
> 480022f0: 0000032f                               /...
> md 48002580 1
> 48002580: 0f00b7a2                               ....
>
> bit USBOTG_PHY_RESET is 0 -> out of reset
>
>
> USB_OTG sees memory hole
> md 480022F0 1
> 480022f0: 0000030f    ....
> md 48002580 1
> 48002580: 0f00c71e    ....
>
> USBOTG_PHY_RESET is 1 -> still in reset when booting linux.
>
> Does that match with how your am3517 boards boot?
>

ps. the dumped register are CONTROL.CONTROL_STATUS and 
CONTROL.CONTROL_DEVCONF2.
