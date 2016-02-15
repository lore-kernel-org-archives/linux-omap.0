From: Tony Lindgren <tony@atomide.com>
Subject: Re: GPIO regression in Linux next caused by syscon change
Date: Mon, 15 Feb 2016 08:01:15 -0800
Message-ID: <20160215160115.GU19432@atomide.com>
References: <20160213002643.GQ19432@atomide.com>
 <20160213004935.GR19432@atomide.com>
 <CA+gwMccZeYimupmGsMX8YbNH9eEA6=Xi=rupciubBwzktfjvBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CA+gwMccZeYimupmGsMX8YbNH9eEA6=Xi=rupciubBwzktfjvBA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

* Philipp Zabel <philipp.zabel@gmail.com> [160214 11:24]:
> I've just replaced the of_iomap() call with an open coded version,
> calling of_address_to_resource() and ioremap() directly. That was
> needed so I can use the struct resource returned by
> of_address_to_resource() to set the syscon_config.max_register. I
> don't see where this could cause resource overlap. Does just setting
> syscon_config.max_register to zero again make the problem disappear?

Yes commenting out the syscon_config.max_register line in your patch
makes things work again.

So what does that tell us about the problem?

Regards,

Tony
