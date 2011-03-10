From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Thu, 10 Mar 2011 17:32:33 +0100
Message-ID: <201103101732.34127.arnd@arndb.de>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103101523.27181.arnd@arndb.de>
	<AANLkTinCCZE5hPC+L6_Uw9UTZekzkTGpW5xxBfzTYa7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTinCCZE5hPC+L6_Uw9UTZekzkTGpW5xxBfzTYa7b@mail.gmail.com>
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
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.>
List-Id: linux-omap@vger.kernel.org

On Thursday 10 March 2011, Linus Walleij wrote:
> On Thu, Mar 10, 2011 at 3:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 10 March 2011, Linus Walleij wrote:
> >> So platform is just the platform bus, not the, you know,
> >> *platform*. There are competing on-chip busses not just one.
> >
> > Good point. Note that I did not mean to put the attributes
> > directly under /sys/platform/, but under /sys/platform/foo/,
> > where foo is the main bus that is used between the CPU core
> > and all the SOC components.
> >
> > This may of course not be easy. If you have an AMBA or PCI
> > bus, you might want to have it represented as
> > /sys/devices/pci0 and /sys/devices/amba0 instead of
> > /sys/devices/platform/foo/amba0/.
> 
> Userspace app doing something needs the name and some
> unique number to be looked up. The first iteration of this
> patch (for the OMAPs) put it in /proc/socinfo with all the
> expected fuzz that this should go into sysfs as result.
> 
> So: where do we suggest Maxime actually put this then?

I'm not sure we even need to define something really new.
Ideally, it could just be properties of the devices in
the device tree, but obviously we're not there yet and
may not even want to go there for all platforms.

> > Making up a pseudo-device that does not refer to any hardware
> > in particular is against the 'devices are only "devices"'
> > rule in Documentation/sysfs-rules.txt.
> 
> Fine then I think we agree this can not realistically be
> under /sys/devices/* unless we first refactor all platforms
> that want to use this mechanism to have top-level-devices.

Not much refactoring required there, just register one
(platform or top-level, I don't care) device named "soc",
and make all platform devices of the soc have a .parent
pointer to that device.

Then you can add attributes to the device.

> > If you really want that, it should be in /sys/kernel/,
> > /sys/firmware/ or a new top-level directory in sysfs.
> >
> > I think putting it in /sys/devices is good, but it has
> > to be an attribute of an actual device, not an empty
> > one that does not even have any child devices. If the
> > device represents the soc, then every other device
> > that is found in the soc should be a child of this one.
> 
> IMO this is not good for socinfo, what is good for apps that
> want socinfo is to just attempt to open+read these file paths.
> Not to invoke libsysfs and start parsing the file tree to see if
> they can find some socinfo somewhere.
> 
> What about we just put it in
> /sys/socinfo/* then, and we have a simple,
> easy-to-understand way for apps that want socinfo to
> read it out?

Possible, but I'd be less happy with this. It's a bit
of duplication of the information that is already present
in both /sys/devices and /sys/firmware.

	Arnd
