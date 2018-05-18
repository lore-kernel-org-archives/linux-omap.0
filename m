From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] omap4-droid4: Use software debounce for gpio-keys
Date: Fri, 18 May 2018 07:32:59 -0700
Message-ID: <20180518143259.GW98604@atomide.com>
References: <20180517233542.30629-1-tony@atomide.com>
 <20180517233542.30629-5-tony@atomide.com>
 <20180518072109.GA31304@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180518072109.GA31304@amd>
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
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Marcel Partap <mpartap@gmx.net>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sre@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, NeKit <nekit1000@gmail.com>, Eyal Reizer <eyalr@ti.com>, Ash Charles <ash@gumstix.com>, Michael Scott <hashcode0f@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180518 07:23]:
> BTW, did you notice that debouncing is wrong on most of the keyboard?
> If you double click a key (most will do, for example "J") it will fail
> to recognize second release and instead of expected "jj", you get
> autorepeat ("jjjjjjjjjjjjjjjjjjjjjj...").

Hmm OK I have not seen that one.

> Ok, I guess main keyboard is not on GPIO...

No it's using omap4-keypad.c.

> > @@ -128,6 +128,7 @@
> >  			gpios = <&gpio5 26 GPIO_ACTIVE_LOW>; /* gpio154 */
> >  			linux,code = <KEY_VOLUMEDOWN>;
> >  			linux,can-disable;
> > +			debounce-interval = <10>;
> 
> I'd say this subtlety is worth a comment.

Good idea, I'll add a comment "Value above 7.95ms for no GPIO hardware
debounce". I'll do it also for duovero.

Regards,

Tony
