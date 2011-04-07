From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCHv2 1/2] Export SoC info through sysfs
Date: Fri, 8 Apr 2011 01:19:10 +0200
Message-ID: <201104080119.11378.arnd@arndb.de>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<alpine.LFD.2.00.1104071840430.28032@xanadu.home>
	<4D9E4114.3090102@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4D9E4114.3090102@bluewatersys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <lee.jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-ke
List-Id: linux-omap@vger.kernel.org

On Friday 08 April 2011, Ryan Mallon wrote:
>>>>> /sys/devices/soc/${NAME}/
>>>>> /sys/devices/platform/soc${NUMBER}/
>>>>
>>>> I prefer the second format here since the path is always the same which
>>>> makes it easier to write parsing tools. The name should be an entry in
>>>> the directory rather than the name of the directory itself.

In the first case, we would ensure that every directory under /sys/devices/soc
is an SOC device, so you would not need to parse the name at all, which is
even simpler. I'm open to other arguments either way, but I think this
one is not particularly important.

> > That would mean two separate instances of Linux, just like two systems.  
> > SMP across multiple SOCs doesn't make much sense, and I don't think they 
> > are likely to be designed for that ability either.
> 
> So we probably don't need the ability to have multiple SoC directories
> under sysfs then?

There are systems that have multiple ones, they are just not as common.

> For the other part of the question, do you think it makes sense for the
> CPU's to be child devices of the SoC (and for the CPU devices to be
> potentially symlinked from the SoC directory)?

No, the CPUs are children of /sys/devices/system, and we should not change
that. Symlinks sound like a good idea though.

	Arnd
