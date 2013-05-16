From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4] ARM:dts:omap4-panda: Update the LED support for the
 panda DTS
Date: Thu, 16 May 2013 15:42:39 -0500
Message-ID: <CAGo_u6oQP6eGkCQe=uTBmUsKQqFbS9_xXYt24_HRtjEr561O=g@mail.gmail.com>
References: <1368636386-17138-1-git-send-email-dmurphy@ti.com>
 <20130515170516.GA6135@kahuna> <5194FCDD.8080209@ti.com>
 <CAGo_u6pX+DdVNWqdPXDChzMr27YAXL_Zvt7DxWBijOCW0rXpkA@mail.gmail.com>
 <5195401B.5070209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5195401B.5070209-l0cyMroinI0@public.gmane.org>
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
To: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 16, 2013 at 3:22 PM, Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org> wrote:
> On 05/16/2013 01:18 PM, Nishanth Menon wrote:
>> On Thu, May 16, 2013 at 10:35 AM, Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org> wrote:
>>> I am not sure you really want to do this.
>>> If I make the pinctrl part of the led structure then the only way the gpio_wk7 on a1-a3 to be configured is when
>>> the CONFIG_LEDS_GPIO flag is set.
>>>
>>> Do you really want that dependency?  You did say it was a key fix
>>> At least this way the pins are configured regardless of that flag.
>> That is better as the system will be left in the pinmux configuration
>> handed over from bootloader.
> So you want to depend on a boot loader to configure pins correctly for the kernel?
> Hmmm seems risky to me.

Not really! if it is a critical pinmux, pinmux defaults are great,
else belongs definitely to device->pinctrl :) depending on bootloader
pinmux implies NOT having pinmux even for device - NO. that is
definitely not what I stated.
Regards,
NM
