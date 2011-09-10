From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: omap: convert per-board modules
	to platform	drivers
Date: Sat, 10 Sep 2011 22:43:44 +0100
Message-ID: <20110910214343.GB21361@opensource.wolfsonmicro.com>
References: <3110288.bQbb0H2ME1@wuerfel>
	<20110909193010.GA2993@opensource.wolfsonmicro.com>
	<20110909205645.GA16355@n2100.arm.linux.org.uk>
	<201109102237.15193.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <201109102237.15193.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Mans Rullgard <mans.rullgard@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Takashi Iwai <tiwai@suse.de>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 10, 2011 at 10:37:15PM +0200, Arnd Bergmann wrote:
> On Friday 09 September 2011, Russell King - ARM Linux wrote:

> > That's just twisted and utterly insane - adding more code for precisely
> > zero benefit what so ever.  Think about it - the device tree is already
> > creating platform devices for entries in the device tree file.  What's

> Exactly. No driver or (worse) user program should ever need to look at
> the top-level compatible property. When you want information about a
> localized part of the system (e.g. the ASoC components), you should
> look up the information for that component.

Right, and this is the state of the art right now.  I can see why people
find this inelegant and want to come up with a way of automatically
generating all these different devices to describe boards especially
with the non-device tree systems, though, so if people want to work on
that stuff I don't see a problem with it.
