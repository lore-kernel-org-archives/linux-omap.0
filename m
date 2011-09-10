From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ASoC: omap: convert per-board modules
	to platform drivers
Date: Sat, 10 Sep 2011 22:37:15 +0200
Message-ID: <201109102237.15193.arnd@arndb.de>
References: <3110288.bQbb0H2ME1@wuerfel>
	<20110909193010.GA2993@opensource.wolfsonmicro.com>
	<20110909205645.GA16355@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110909205645.GA16355@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, linaro-dev@lists.linaro.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Mans Rullgard <mans.rullgard@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Takashi Iwai <tiwai@suse.de>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 09 September 2011, Russell King - ARM Linux wrote:
> That's just twisted and utterly insane - adding more code for precisely
> zero benefit what so ever.  Think about it - the device tree is already
> creating platform devices for entries in the device tree file.  What's
> the point of having this special ASoC code look up the platform compatible
> property in a table of strings to find a different string to manually
> create a device with.  Why not just add the bloody device to the DT
> file in the first place?  That's partly what DT is there for - to create
> platform specific struct devices.

Exactly. No driver or (worse) user program should ever need to look at
the top-level compatible property. When you want information about a
localized part of the system (e.g. the ASoC components), you should
look up the information for that component.

	Arnd
