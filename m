From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP3: PM: Enable wake-up from McBSP2,
	3 and 4 modules
Date: Wed, 3 Mar 2010 16:46:07 +0200
Message-ID: <20100303164607.7024e8d0.jhnikula@gmail.com>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267621689-30337-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1267621689-30337-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, tony@atomide.com, broonie@opensource.wolfsonmicro.com, ext-eero.nurkkala@nokia.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On Wed,  3 Mar 2010 15:08:05 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Wake-up from McBSP ports are needed, especially when the THRESHOLD
> dma mode is in use for audio playback.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
How about the commit e3d9329640e4b291cdd2c6d178774c28bba47d59 in
mainline?


-- 
Jarkko
