From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
Date: Wed, 12 Sep 2018 10:38:16 -0700
Message-ID: <20180912173816.GL5662@atomide.com>
References: <20180910200624.4494-1-tony@atomide.com>
 <444bae18-9737-8e13-2a0f-c08863ae1336@ti.com>
 <20180911182419.GC5662@atomide.com>
 <a10ae1a9-ed6a-468e-5a3e-8c120bab9acf@ti.com>
 <20180912004252.GH5662@atomide.com>
 <2cfe2f9d-a465-0568-bf48-8dcde535ff99@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <2cfe2f9d-a465-0568-bf48-8dcde535ff99@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180912 16:13]:
> 
> 
> On 09/11/2018 07:42 PM, Tony Lindgren wrote:
> > * Grygorii Strashko <grygorii.strashko@ti.com> [180912 00:27]:
> > > Thanks Tony, but it's still not completely clear -
> > > it's important to see values of CLKSTCTRL before/after idle for not working
> > > case and GPIO SYSC/SYSS registers. There are some combinations which may
> > > affect on this. So, if you can, pls.
> > 
> > Sure I'll do some reg dumps for you tomorrow as I just started
> > an overnight test with randomly pinging the wlan interface
> > from outside to make sure it wakes up and keeps idling.
> 
> Pls, postpone this until we finish our discussion/debugging

Yeah I just sent you three gpio dump files privately to avoid
spamming the list with them.

Regards,

Tony
