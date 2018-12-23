From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: dts: Add wlcore wakeirq for omap3-evm
Date: Sun, 23 Dec 2018 08:30:40 -0800
Message-ID: <20181223163040.GO6707@atomide.com>
References: <20181213230411.5009-1-tony@atomide.com>
 <CAHCN7xJmde1RJOMMqexR0uNiVEYjztTV4qXvkcjqb+w7R1vmpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xJmde1RJOMMqexR0uNiVEYjztTV4qXvkcjqb+w7R1vmpA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [181222 20:54]:
> I noticed for your patch, I noticed you listed both the IRQ, gpio 149
> as well as uart1_rts.  Looking at the device tree, I see that
> uart1_rts is configured as gpio 149.

The uart1_rts is just the pad name used in the TRM, so it should
probably say uart1_rts.gpio_149 meaning pad uart1_rts is muxed to
gpio_149.

Would that clear the issue for you?

> I did a quick scan of other
> boards, I haven't noticed other boards listing the same gpio twice,
> once under IRQ and once under the pmx_core wakeup.  Is that something
> we should do on other boards, or is that something unique to the
> omap3-evm?

No just trying to come up with some some less confusing comments,
but obviously that did not work so far :)

Regards,

Tony
