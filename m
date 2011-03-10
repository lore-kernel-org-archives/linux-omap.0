From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Thu, 10 Mar 2011 14:25:19 +0100
Message-ID: <AANLkTikFCAC-hdv0Q_9eQs31XHHEc4wYqRjfY0S=FYcz@mail.gmail.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103092058.34236.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201103092058.34236.arnd@arndb.de>
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
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infrade>
List-Id: linux-omap@vger.kernel.org

2011/3/9 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 09 March 2011 17:59:20 Maxime Coquelin wrote:
>> Common base to export System-on-Chip related informations through sysfs.
>>
>> Creation of a "soc" directory under /sys/devices/system/.
>
> Why under system?
>
> As far as I can tell, the SOC already exists as a platform device
> under /sys/devices/platform,

This is from U8500:

/sys/devices/platform ls

ab8500-i2c.0   gpio.0         gpio.5         nmk-i2c.0      uevent
arm-pmu.0      gpio.1         gpio.6         nmk-i2c.1
cpufreq-u8500  gpio.2         gpio.7         nmk-i2c.2
dma40.0        gpio.3         gpio.8         nmk-i2c.3
gpio-keys.0    gpio.4         musb-ux500.0   reg-dummy

In our case the above are platform_device:s and also MFD cells,
children of I2C devices (anything prefixed with ab8500-*) which
have absolutely *nothing* to do with what is inside the SoC.

Further these SoC entries don't even have a device of *any* kind tied
to them. It's just hooks reading binary right out of some extremely
system-specific memory locations and producing matching strings.

"platform" means "platform bus" in this context, does it not?
So your reasoning is that since on SoC:s there is one dominant
bus called the platform bus that should also hold a reference to the
SoC-specific stuff.

On the ARM Versatiles this isn't even true: there the dominant
bus is the AMBA (PrimeCell) bus, and the U8500 uses a mixture
of both. AMBA devices incidentally turn up as entries directly
in /sys/devices:

/sys/devices ls
platform   sdi0       sdi4       system     uart1      virtual
rtc-pl031  sdi2       ssp0       uart0      uart2

The sdi, uart & rtc you see here are AMBA devices.

So platform is just the platform bus, not the, you know,
*platform*. There are competing on-chip busses not just one.

So standardizing the location here,
/sys/devices/system contain these more neutral things:

/sys/devices/system ls
clocksource  cpu          timekeeping  timer

IMHO socinfo fits here, just as it is in the patch.

This might be a bit of bikeshed-color discussion but I
happen to like this black color sooooo much...

Just my =800.01
Linus Walleij
