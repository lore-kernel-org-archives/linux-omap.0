From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: mcbsp - add machine threshold
	callback
Date: Tue, 18 May 2010 13:38:26 -0700
Message-ID: <20100518203825.GC15951@opensource.wolfsonmicro.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<1274213594-26554-4-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1274213594-26554-4-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Tue, May 18, 2010 at 09:13:13PM +0100, Liam Girdwood wrote:
> Add a mechanism to register a machine specific callback
> to calculate and set the McBSP Tx/Rx threshold.

It's a shame the default implementation can't work for everyone but
there we are.  :(

> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>

All of these:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
