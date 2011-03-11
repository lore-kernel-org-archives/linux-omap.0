From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [RFC PATCHv2 2/2] ux500: Export U8500 SoC info through sysfs
Date: Fri, 11 Mar 2011 15:11:10 +0100
Message-ID: <20110311141110.GS9351@game.jcrosoft.org>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299846911-15782-3-git-send-email-maxime.coquelin-nonst@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1299846911-15782-3-git-send-email-maxime.coquelin-nonst@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel
List-Id: linux-omap@vger.kernel.org

On 13:35 Fri 11 Mar     , Maxime Coquelin wrote:
> ST-Ericsson's U8500 implementation.
> Register sysfs SoC interface, and exports:
> 	- Machine name
> 	- Family name
> 	- SoC ID
> 	- Silicon process
> 	- Silicon revision number.
I propose some weeks ago exactly the same kind of patch

and Greg point that we need to create a bus

Best Regards,
J.
