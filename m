From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: omap4-panda: Add USB Host support
Date: Wed, 19 Jun 2013 07:34:38 -0500
Message-ID: <51C1A55E.9040500@ti.com>
References: <1371571487-14389-1-git-send-email-rogerq@ti.com>
 <1371571487-14389-2-git-send-email-rogerq@ti.com> <51C106A1.9030001@ti.com>
 <51C15F7E.5020305@ti.com> <20130619074605.GW5523@atomide.com>
 <51C183AC.8040801@ti.com> <20130619122715.GA5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130619122715.GA5523@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 06/19/2013 07:27 AM, Tony Lindgren wrote:
> * Benoit Cousson <b-cousson@ti.com> [130619 03:17]:
>> On 06/19/2013 02:46 AM, Tony Lindgren wrote:
>>>
>>> We have a similar issue with the MMC1 PBIAS. I think in the long run we
>>> should expand regulator (and possibly pinctrl) framework(s) to handle
>>> comparators. We could just assume that a comparatator is a regulator,
>>> and have a comparator binding that just uses the regulator code.
>>
>> In the case of pbias, the pinctrl seems to be a much better fit for
>> my point of view. pinctrl can handle pin configuration and this is
>> what the pbias is in the case of MMC pins.
>
> Well just recently Linus W specifically wanted us to use regulator
> framework for the MMC1 PBIAS rather than pinctrl. That's because
> from consumer driver point of view, it changes voltage and there's
> a delay involved. So I guess no conclusion yet, and it's best to
> do stand alone drivers to deal with those that use pinctrl for the
> pinctrl specific parts and export it as a regulator for the consumer
> devices.

In the case of pbias, the boundary is not that clear, and it is true 
that writing a complete pinctrl driver is really overkill.
I've tried in the past, and gave up due to the complexity of fmwk and 
the lack of time. I still think, it is a much better fmwk to handle pin 
configuration than the regulator fmwk.

> That's pretty much along the lines what Roger has done,
> except the transceiver could use the pinctrl-single,bits for the
> muxing and pinconf.

Well, in that case, this is a reset line, so it does not have anything 
to do with voltage :-)

Anyway, thanks to Florian, we know that there is a real solution to that 
problem. It is just not merged now :-(

Regards,
Benoit
