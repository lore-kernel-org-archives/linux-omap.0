From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap: convert per-board modules to
 platform drivers
Date: Thu, 8 Sep 2011 09:37:43 -0700
Message-ID: <20110908163742.GD3098@opensource.wolfsonmicro.com>
References: <1315494354-17597-1-git-send-email-mans.rullgard@linaro.org>
	<4E68DBF7.1030009@metafoo.de>
	<CAG5Tg6XxGP1YhQ0zW3f=1EkZfAmb9vj3pBemeSazpH1_CZ3OzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAG5Tg6XxGP1YhQ0zW3f=1EkZfAmb9vj3pBemeSazpH1_CZ3OzQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mans Rullgard <mans.rullgard@linaro.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 08, 2011 at 04:41:30PM +0100, Mans Rullgard wrote:
> On 8 September 2011 16:15, Lars-Peter Clausen <lars@metafoo.de> wrote:

> > Use different device driver names for different drivers.

> I guess this worked by accident on my system.

> Are there any other changes needed?

Check the N810 code - it looks like that driver should be taking
platform data to distinguish between the two models.  Possibly also rx51
though I only looked at the diff.  Also it should probably be grabbing
the clocks before it registers the card.
