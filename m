From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: TWL4030: Make sure,
 that the codec is powered on startup
Date: Mon, 2 Nov 2009 17:28:41 +0000
Message-ID: <20091102172841.GB8546@rakim.wolfsonmicro.main>
References: <1257165295-9352-1-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-2-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-3-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-4-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1257165295-9352-5-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 02, 2009 at 02:34:54PM +0200, Peter Ujfalusi wrote:
> Set the codec->bias_level to SND_SOC_BIAS_OFF before changing
> the initial bias level to STANDBY.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

I've applied this one immediately since it doesn't need any of the other
stuff.
