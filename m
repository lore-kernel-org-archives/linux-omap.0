From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v7 3/6] DTS: gta04: add uart2 child node for w2sg0004 GPS
 receiver
Date: Sat, 16 Jun 2018 17:37:59 +0200
Message-ID: <23B66F6C-83A1-4666-A4E1-D127C6E3446B@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
 <9ebb28aed589aca8e9b5bc5c910f1d2f0d62669d.1525340143.git.hns@goldelico.com>
 <20180614194428.GA17808@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180614194428.GA17808@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pyra-handheld.com, Johan Hovold <johan@kernel.org>, "Andrew F. Davis" <afd@ti.com>, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Russell King <linux@armlinux.org.uk>, letux-kernel@openphoenux.org, Thierry Reding <treding@nvidia.com>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

> Am 14.06.2018 um 21:44 schrieb Pavel Machek <pavel@ucw.cz>:
> 
> On Thu 2018-05-03 11:35:48, H. Nikolaus Schaller wrote:
>> GTA04 has a W2SG0004 module connected to UART2 of the OMAP3
>> processor. A GPIO can pulse the on/off toggle switch.
>> 
>> Note that there is no WAKEUP output from the W2SG0004,
>> hence we can't use the generic SirfStar binding.
>> 
>> The VSIM regulator is used to power on/off the LNA of an
>> external active GPS antenna so that a driver can turn the
>> LNA off if GPS is not needed to save battery energy.
> 
> This reads as if you did low->high->low to turn GPS on, then
> low->high->low to turn GPS off again. Is that correct?

Yes, it controls a toggle switch inside the gps module.

Data sheet (page 5, table 1):

	http://download.goldelico.com/gta04-hardware/Datasheets/W2SG0004_Datasheet_Rev1.81.pdf

Well, it says it wants a "Low going pulse (two RTC ticks), for power save".
So this indicates "high->low->high" and the chip responds on an unspecified edge.

If I speculate about the logic behind this, I think there was the concept of a
push-button at the navigator's console of a vessel (button is connected through
a single long wire and grounded at the console) to turn the receiver on or off.

Now the question is which edge turns it on or of. Pushing or releasing the button?
high->low or low->high? There is no hint in the data sheet.

If we assume it has not been changed in the w2sg0084i, we can look at page 9, figure 3

	https://www.mouser.com/ds/2/437/W2SG0084i_Datasheet_Rev1%2061-1114.pdf

to find that a rising edge changes the power state.

Experiments with manually controlling the w2sg0004 through /sys/class/gpio have
confirmed that that the rising edge is relevant.

Now on power-on there seems to be a special rule. If the on/off line is
permanently grounded (i.e. low), the module will turn on automatically at
power-on. So there is no need for any edge.

But since we don't want the module to be turned on at power-on (while U-Boot
is running) we have code there to initialize the gpio line to high.

Unfortunately you have not cited the code of the patch, so let me add it back:

> +		/* GPIO_145: trigger for on/off-impulse for w2sg0004 */
> +		enable-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;

So there it is described as GPIO_ACTIVE_HIGH.

This might seem to contradict the data sheet which talks about a low going pulse,
but better reflects the active low->high edge.

I hope this answers your question completely.

BR and thanks,
Nikolaus
