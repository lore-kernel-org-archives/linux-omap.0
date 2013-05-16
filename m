From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v4] ARM:dts:omap4-panda: Update the LED support for the
 panda DTS
Date: Thu, 16 May 2013 15:22:51 -0500
Message-ID: <5195401B.5070209@ti.com>
References: <1368636386-17138-1-git-send-email-dmurphy@ti.com>
 <20130515170516.GA6135@kahuna> <5194FCDD.8080209@ti.com>
 <CAGo_u6pX+DdVNWqdPXDChzMr27YAXL_Zvt7DxWBijOCW0rXpkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGo_u6pX+DdVNWqdPXDChzMr27YAXL_Zvt7DxWBijOCW0rXpkA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, lkml <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 05/16/2013 01:18 PM, Nishanth Menon wrote:
> On Thu, May 16, 2013 at 10:35 AM, Dan Murphy <dmurphy@ti.com> wrote:
>> I am not sure you really want to do this.
>> If I make the pinctrl part of the led structure then the only way the gpio_wk7 on a1-a3 to be configured is when
>> the CONFIG_LEDS_GPIO flag is set.
>>
>> Do you really want that dependency?  You did say it was a key fix
>> At least this way the pins are configured regardless of that flag.
> That is better as the system will be left in the pinmux configuration
> handed over from bootloader.
So you want to depend on a boot loader to configure pins correctly for the kernel?
Hmmm seems risky to me.
> The point being, muxing up pins even when not needed(config switched
> off) has no real benefit - in this case albeit, the default mux was
> causing a bug.
> pinctrl IMHO should be considered as any other resource, if it is not
> mandatory for boot, and needed only for a device functionality when
> probed, it should done there only.
>
> just my 2 cents.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
------------------
Dan Murphy
