From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Add support for OMAP3 EVM
Date: Tue, 25 Nov 2008 14:52:58 +0000
Message-ID: <20081125145257.GD12414@sirena.org.uk>
References: <1227591577-23414-1-git-send-email-anuj.aggarwal@ti.com>
	<20081125132120.1d740c04.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20081125132120.1d740c04.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Anuj Aggarwal <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, ext Misael Lopez Cruz <mesak82@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 25, 2008 at 01:21:20PM +0200, Jarkko Nikula wrote:

> Or if those EVM's & SDP's can route TWL4030 audio connections more
> flexible than Beagle but somewhat similar manner, then probably have one
> single machine driver for all EVM's?

> Otherwise it doesn't make very much sense to have n similar machine
> drivers where only functions and variable names differ.

Yes, it looks like a lot of these drivers could be redone along the
lines of s3c24xx_uda134x.c with platform data specifying the differences
between the boards.
