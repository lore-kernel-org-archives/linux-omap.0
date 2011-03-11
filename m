From: Greg KH <greg@kroah.com>
Subject: Re: [RFC PATCHv2 1/2] Export SoC info through sysfs
Date: Fri, 11 Mar 2011 14:03:33 -0800
Message-ID: <20110311220333.GA30232@kroah.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<20110311175816.GC7291@besouro.research.nokia.com>
	<20110311193330.GA14204@kroah.com>
	<201103112242.43962.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201103112242.43962.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.orgD
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 11, 2011 at 10:42:43PM +0100, Arnd Bergmann wrote:
> On Friday 11 March 2011 20:33:30 Greg KH wrote:
> > Make this a "real" device not /sys/socinfo please.  It can be a platform
> > device that export the needed information, that way you can have
> > multiple ones.
> 
> Note that the version 1 of this patch had a device, and I argued against
> that patch on the basis that anything under /sys/devices/ should
> reflect an actual part of the hardware, which socinfo by itself
> does not.

Why is the overall SoC not a device?  cpus are (well, they will be in a
few kernel versions in the future), so what makes the other bits somehow
"special"?

> I believe the best way to represent this really is to have
> a device (platform or other, I don't care) that:
> 
> * represents the SOC in its entirety
> * has the subdevices that are part of the SOC as direct
>   or indirect children
> * can be identified easily as a SOC (through one of
>   its name, its place in the hierarchy or its bus_type)
> * has the standard device attributes proposed in Maxime's
>   patch.

That's fine, as it would be a real "struct device" :)

thanks,

greg k-h
