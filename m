From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8] gpio: twl4030: Fix regression for twl gpio output
Date: Thu, 14 Nov 2013 09:37:01 -0800
Message-ID: <20131114173701.GG10317@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-6-git-send-email-tony@atomide.com>
 <52849BCF.6060203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <52849BCF.6060203@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [131114 01:46]:
> Hi Tony,
> 
> On 11/14/2013 04:35 AM, Tony Lindgren wrote:
> > Commit c111feabe2e2 (gpio: twl4030: Cache the direction and output
> > states in private data) improved things in general, but caused a
> > regression for setting the GPIO output direction.
> > 
> > The change reorganized twl_direction_out() and twl_set() and swapped
> > the function names around in the process. While doing that, a bug got
> > introduced that's not obvious while reading the patch as it appears
> > as no change to the code.
> > 
> > The bug is we now call function twl4030_set_gpio_dataout() twice in
> > both twl_direction_out() and twl_set(). Instead, we should first
> > call twl_direction_out() in twl_direction_out() followed by
> > twl4030_set_gpio_dataout() in twl_set().
> > 
> > This regression probably has gone unnoticed for a long time as the
> > bootloader may have set the GPIO direction properly in many cases.
> > This fixes at least the LCD panel not turning on omap3 LDP for
> > example.
> 
> Thanks for catching this. I have a recollection that I have tested the GPIO
> and it appeared to be working fine..

Yes it probably worked fine if the bootloader set the direction :)
This is cc stable kind of patch for sure.

Regards,

Tony
