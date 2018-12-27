From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: Add wlcore wakeirq for omap3-evm
Date: Thu, 27 Dec 2018 08:33:30 -0600
Message-ID: <CAHCN7xJKyjXb6br-f+_q_dQxkqWHFxFfA+X_yYG4eh8w7RW8SQ@mail.gmail.com>
References: <20181213230411.5009-1-tony@atomide.com>
 <CAHCN7xJmde1RJOMMqexR0uNiVEYjztTV4qXvkcjqb+w7R1vmpA@mail.gmail.com>
 <20181223163040.GO6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181223163040.GO6707@atomide.com>
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
Cc: devicetree <devicetree@vger.kernel.org>, linux-omap@vger.kernel.org, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Dec 23, 2018 at 10:30 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [181222 20:54]:
> > I noticed for your patch, I noticed you listed both the IRQ, gpio 149
> > as well as uart1_rts.  Looking at the device tree, I see that
> > uart1_rts is configured as gpio 149.
>
> The uart1_rts is just the pad name used in the TRM, so it should
> probably say uart1_rts.gpio_149 meaning pad uart1_rts is muxed to
> gpio_149.
>
> Would that clear the issue for you?

That part I understand.  I poorly phrased my question.  What was
mostly confusing to me is why both irq and wakeup interrupts are
needed since it seems like

<&gpio5 21 IRQ_TYPE_EDGE_RISING>,

and
<&omap3_pmx_core 0x14e>;
point to the same pin.  Or did I mis-interpret the datasheet again?  :-)


adam
>
> > I did a quick scan of other
> > boards, I haven't noticed other boards listing the same gpio twice,
> > once under IRQ and once under the pmx_core wakeup.  Is that something
> > we should do on other boards, or is that something unique to the
> > omap3-evm?
>
> No just trying to come up with some some less confusing comments,
> but obviously that did not work so far :)
>
> Regards,
>
> Tony
