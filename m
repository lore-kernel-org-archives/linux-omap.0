From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Thu, 10 Mar 2011 15:23:26 +0100
Message-ID: <201103101523.27181.arnd@arndb.de>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103092058.34236.arnd@arndb.de>
	<AANLkTikFCAC-hdv0Q_9eQs31XHHEc4wYqRjfY0S=FYcz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTikFCAC-hdv0Q_9eQs31XHHEc4wYqRjfY0S=FYcz@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infrade>
List-Id: linux-omap@vger.kernel.org

On Thursday 10 March 2011, Linus Walleij wrote:
> >
> > As far as I can tell, the SOC already exists as a platform device
> > under /sys/devices/platform,
> 
> This is from U8500:
> 
> /sys/devices/platform ls
> 
> ab8500-i2c.0   gpio.0         gpio.5         nmk-i2c.0      uevent
> arm-pmu.0      gpio.1         gpio.6         nmk-i2c.1
> cpufreq-u8500  gpio.2         gpio.7         nmk-i2c.2
> dma40.0        gpio.3         gpio.8         nmk-i2c.3
> gpio-keys.0    gpio.4         musb-ux500.0   reg-dummy
> 
> In our case the above are platform_device:s and also MFD cells,
> children of I2C devices (anything prefixed with ab8500-*) which
> have absolutely nothing to do with what is inside the SoC.

Ok, I must correct myself:

There *should* *be* an SOC device that is the parent of all
devices that are part of the SOC, instead of a bunch of
random stuff getting placed directly under /sys/devices/platform.

Most of the stuff you have there really isn't a top-level
platform device at all.

> Further these SoC entries don't even have a device of any kind tied
> to them. It's just hooks reading binary right out of some extremely
> system-specific memory locations and producing matching strings.

On the SOC devices that I've dealt with, they are organized in
some hierarchy of buses, and each bus has its own registers
that identify it, and should therefore be represented in
sysfs as a device with other child devices.

Making up a pseudo-device that does not refer to any hardware
in particular is against the 'devices are only "devices"'
rule in Documentation/sysfs-rules.txt.

If you really want that, it should be in /sys/kernel/,
/sys/firmware/ or a new top-level directory in sysfs.

I think putting it in /sys/devices is good, but it has
to be an attribute of an actual device, not an empty
one that does not even have any child devices. If the
device represents the soc, then every other device
that is found in the soc should be a child of this one.

> "platform" means "platform bus" in this context, does it not?
> So your reasoning is that since on SoC:s there is one dominant
> bus called the platform bus that should also hold a reference to the
> SoC-specific stuff.

No. Be careful not to confuse bus and bus_type here. Platform
bus refers to the bus_type and it can hold any number of
devices that are directly addressable but cannot be probed.

> On the ARM Versatiles this isn't even true: there the dominant
> bus is the AMBA (PrimeCell) bus, and the U8500 uses a mixture
> of both. AMBA devices incidentally turn up as entries directly
> in /sys/devices:
> 
> /sys/devices ls
> platform   sdi0       sdi4       system     uart1      virtual
> rtc-pl031  sdi2       ssp0       uart0      uart2
> 
> The sdi, uart & rtc you see here are AMBA devices.

I would argue that these belong into a top-level AMBA bus device
that holds all devices connected to one AMBA bus. It's a
really bad idea to put random devices into a the global
/sys/devices/ namespace, because of potential conflicts.

> So platform is just the platform bus, not the, you know,
> *platform*. There are competing on-chip busses not just one.

Good point. Note that I did not mean to put the attributes
directly under /sys/platform/, but under /sys/platform/foo/,
where foo is the main bus that is used between the CPU core
and all the SOC components.

This may of course not be easy. If you have an AMBA or PCI
bus, you might want to have it represented as
/sys/devices/pci0 and /sys/devices/amba0 instead of
/sys/devices/platform/foo/amba0/.

	Arnd
