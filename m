From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4 v2] ASoC/MFD/OMAP: TWL4030: APLL_CTL
	handling change
Date: Mon, 9 Nov 2009 14:02:58 -0800
Message-ID: <20091109220258.GI23952@atomide.com>
References: <1257321500-27049-1-git-send-email-peter.ujfalusi@nokia.com>
	<20091104102040.GA25922@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091104102040.GA25922@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, sameo@linux.intel.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [091104 02:20]:
> On Wed, Nov 04, 2009 at 09:58:16AM +0200, Peter Ujfalusi wrote:
> 
> > The following series changes the way how the APLL_CTL register is handled by
> > the twl4030 codec related drivers.
> 
> I'm OK with this but I'll wait for acks from Tony and Samuel before
> applying.

Looks good to me, replied with my ack in the board-*.c files patch
in this series.

Regards,

Tony
