From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCHv2 1/1] OMAP_TWL4030 SoC Audio driver.
Date: Thu, 27 Nov 2008 15:54:39 +0000
Message-ID: <20081127155438.GE3933@sirena.org.uk>
References: <1227790257-14221-1-git-send-email-stanley.miao@windriver.com>
	<1227790257-14221-2-git-send-email-stanley.miao@windriver.com>
	<20081127131923.GC3933@sirena.org.uk>
	<1227801365.14497.136.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1227801365.14497.136.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 27, 2008 at 11:56:05PM +0800, stanley.miao wrote:
> On Thu, 2008-11-27 at 13:19 +0000, Mark Brown wrote:

> > As I said in response to your original posting I'd strongly urge you to
> > look at the s3c24xx_uda134x driver for an example of how something like
> > this can be implemented.

> I tried to make it work whether there is platform_data or not. If I
> write it according to s3c24xx_uda134x style, every board should register
> a platform_device. 

Yes, exactly.

> > This still has the previous problem with your use of ifdefs: it means
> > that it's not possible to build the driver for configurations that both
> > do and don't need this.

> This is why there is a SND_OMAP_TWL4030_SPECIFIC in Kconfig. If there
> are some board specific features, SND_OMAP_TWL4030_SPECIFIC should be
> selected under a board config, and omap_twl4030_specific_init() will be
> difined in the board specific file.

As previously mentioned this prevents building a single kernel with
support for multiple boards.  That would be a regression from the
current situation and isn't really acceptable.
