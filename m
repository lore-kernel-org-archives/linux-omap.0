From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Fix TW4030 Kconfig dependency
Date: Tue, 25 Nov 2008 15:30:14 +0000
Message-ID: <20081125153013.GH12414@sirena.org.uk>
References: <1227587172-9523-1-git-send-email-arunks@mistralsolutions.com>
	<200811242044.13438.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200811242044.13438.david-b@pacbell.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Brownell <david-b@pacbell.net>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, arunks@mistralsolutions.com, steve@sakoman.com
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 24, 2008 at 08:44:13PM -0800, David Brownell wrote:
> On Monday 24 November 2008, arunks@mistralsolutions.com wrote:

> > Fixes Kconfig dependency of TWL4030 audio codec driver
> > with TWL4030 core driver on both overo and omap2evm
> > boards

> > Signed-off-by: Arun KS <arunks@mistralsolutions.com>

> Good idea.  :)

> Acked-by: David Brownell <dbrownell@users.sourceforge.net>

Applied.

Might it be an idea to have the relevant machine drivers select the
TWL4030 support?  This would prevent them disabling it but the chip is
such a basic part of these systems that that doesn't seem unreasonable.
