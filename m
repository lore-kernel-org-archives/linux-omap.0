From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2 3/5] ASoC: core: Add delay operation to
 snd_soc_dai_ops
Date: Wed, 03 Mar 2010 13:28:00 +0000
Message-ID: <1267622880.3185.2.camel@odin>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267621689-30337-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1267621689-30337-5-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, tony@atomide.com, broonie@opensource.wolfsonmicro.com, ext-eero.nurkkala@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-03-03 at 15:08 +0200, Peter Ujfalusi wrote:
> The delay callback can be used by the core to query the delay
> on the dai caused by FIFO or delay in the platform side.
> In case if both CPU and CODEC dai has FIFO the delay reported
> by each will be added to form the full delay on the chain.
> If none of the dai has FIFO, than the delay will be kept as
> zero.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
