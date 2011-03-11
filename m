From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCHv2 1/2] Export SoC info through sysfs
Date: Fri, 11 Mar 2011 22:42:43 +0100
Message-ID: <201103112242.43962.arnd@arndb.de>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<20110311175816.GC7291@besouro.research.nokia.com>
	<20110311193330.GA14204@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110311193330.GA14204@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Daniel
List-Id: linux-omap@vger.kernel.org

On Friday 11 March 2011 20:33:30 Greg KH wrote:
> Make this a "real" device not /sys/socinfo please.  It can be a platform
> device that export the needed information, that way you can have
> multiple ones.

Note that the version 1 of this patch had a device, and I argued against
that patch on the basis that anything under /sys/devices/ should
reflect an actual part of the hardware, which socinfo by itself
does not.

I believe the best way to represent this really is to have
a device (platform or other, I don't care) that:

* represents the SOC in its entirety
* has the subdevices that are part of the SOC as direct
  or indirect children
* can be identified easily as a SOC (through one of
  its name, its place in the hierarchy or its bus_type)
* has the standard device attributes proposed in Maxime's
  patch.

	Arnd
