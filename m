From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] ASoC: tpa6130a2: model handling cleanup
Date: Wed, 21 Sep 2011 16:03:17 +0100
Message-ID: <20110921150317.GE6245@opensource.wolfsonmicro.com>
References: <1314704394-31298-1-git-send-email-peter.ujfalusi@ti.com>
	<4E5CE7EA.4000101@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4E5CE7EA.4000101@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 30, 2011 at 04:38:50PM +0300, Jarkko Nikula wrote:

> Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

I applied these with the last two patches squashed together in order to
preserve bisection - the two patches should have been combined as patch
2 removes a field that the existing code is using.
