From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Thu, 10 Mar 2011 18:08:38 +0100
Message-ID: <AANLkTin=Octa0BsxAh2QPsJXVCOKNrzELkcNJO88J+pN@mail.gmail.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103101523.27181.arnd@arndb.de>
	<AANLkTinCCZE5hPC+L6_Uw9UTZekzkTGpW5xxBfzTYa7b@mail.gmail.com>
	<201103101732.34127.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201103101732.34127.arnd@arndb.de>
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
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 10, 2011 at 5:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 10 March 2011, Linus Walleij wrote:
>> On Thu, Mar 10, 2011 at 3:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thursday 10 March 2011, Linus Walleij wrote:
> Not much refactoring required there, just register one
> (platform or top-level, I don't care) device named "soc",
> and make all platform devices of the soc have a .parent
> pointer to that device.
>
> Then you can add attributes to the device.

But since the name of the top-level device name is not
subject to standardization, I suspect that an app
not knowing which SoC it is running on will indeed
need to parse through the entire sysfs/devices/*
hierarchy to see if it can find some soc name.

No easy feat, indeed libsysfs can help you.
Equal to:

x=`find /sys/devices | grep mach-name`
cat x

Compare this to getting the *name* of the hardware
you want to obtain the SoC-info for. Easy:

grep Hardware /proc/cpuinfo

What I'm trying to get at is that the user of this
info isn't really interested in any device tree structure,
it just becomes an obstacle s/he has to overcome
to get this info out.

But there may be a compromise: if we create the
socinfo in one place in the device tree (possibly the
top node, or a dedicated device) then class it?

/sys/class/soc/soc0 -> ../../devices/platform/top-node

Then you find your entries easily by opening
/sys/class/soc/soc0/* ?

If the socinfo interface is singleton (and why should
it not be) then:

/sys/class/soc -> ../devices/platfom/top-node

Or is this thing too trivial to have it's own class?

Yours,
Linus Walleij
