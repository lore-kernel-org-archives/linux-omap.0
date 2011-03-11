From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Fri, 11 Mar 2011 17:14:12 +0100
Message-ID: <201103111714.12332.arnd@arndb.de>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103101732.34127.arnd@arndb.de>
	<AANLkTin=Octa0BsxAh2QPsJXVCOKNrzELkcNJO88J+pN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTin=Octa0BsxAh2QPsJXVCOKNrzELkcNJO88J+pN@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Greg KH <greg@kroah.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>"linux-arm-kernel@lists.infradead.org" <linux-a>
List-Id: linux-omap@vger.kernel.org

On Thursday 10 March 2011, Linus Walleij wrote:
> What I'm trying to get at is that the user of this
> info isn't really interested in any device tree structure,
> it just becomes an obstacle s/he has to overcome
> to get this info out.
> 
> But there may be a compromise: if we create the
> socinfo in one place in the device tree (possibly the
> top node, or a dedicated device) then class it?
> 
> /sys/class/soc/soc0 -> ../../devices/platform/top-node
> 
> Then you find your entries easily by opening
> /sys/class/soc/soc0/* ?

That would be one way of finding all soc nodes, in
case we want to have multiple ones. Similarly,
it could be done based on

1. the name under /sys/devices/platform:

/sys/devices/platform/soc0
/sys/devices/platform/soc1
/sys/devices/platform/soc2

2. a new bus_type for soc devices, with bus_attributes:

/sys/bus/soc/devices/foo0 -> ../../../devices/platform/foo0
/sys/bus/soc/devices/bar0 -> ../../../devices/platform/bar0
/sys/bus/soc/devices/bar1 -> ../../../devices/platform/bar1

3. A new top-level device besides /sys/devices/platform (like PCI):

/sys/devices/soc0
/sys/devices/soc1
/sys/devices/soc2

> If the socinfo interface is singleton (and why should
> it not be) then:
> 
> /sys/class/soc -> ../devices/platfom/top-node
> 
> Or is this thing too trivial to have it's own class?

In case of a singleton, I'd just use a fixed device as
the parent:

/sys/devices/platform/soc/

or

/sys/devices/soc/

And pass that as the parent for all devices under it.

	Arnd
