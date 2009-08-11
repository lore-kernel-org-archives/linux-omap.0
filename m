From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 11/20] OMAP: McBSP: Add link DMA mode
 selection
Date: Tue, 11 Aug 2009 09:04:57 +0300
Message-ID: <20090811090457.d89afd3e.jhnikula@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<20090805103900.5ad89efe.jhnikula@gmail.com>
	<200908051158.57440.peter.ujfalusi@nokia.com>
	<1FFEF31EBAA4F64B80D33027D4297760047F6AED01@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1FFEF31EBAA4F64B80D33027D4297760047F6AED01@NOK-EUMSG-02.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-Eero.Nurkkala@nokia.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, alsa-devel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Sorry for the late reply.

On Thu, 6 Aug 2009 20:15:40 +0200
<ext-Eero.Nurkkala@nokia.com> wrote:

> Well, the element mode is fine for !McBSP2. One doesn't really loose the
> buffer pointer accuracy, because you can get the last DMA irq timestamp
> with SNDRV_PCM_IOCTL_TTSTAMP (and compare that to current time).
> The accuracy is not far off from the element mode? (If you read the DMA
> portion of TRM, I think there were some issues as well)
> 
Well the threshold mode makes the offset returned from omap_pcm_pointer
to behave gradually as the threshold size is set. This would affect a SW
which is doing sub-period processing like mixing audio n samples ahead
the current DMA pointer. Of course HW buffer in McBSP2 adds static
latency but otherwise processing is similar compared to other ports and
OMAPs.

I would like to see this new threshold based transfer functionality to
be integrated so that projects can take the advantage of it and helps
generic PM development too but I don't want that it would cause any
regression now. Later on it is easy to switch threshold based transfer
to be the default for McBSP2 on OMAP3 but it's safer to keep current
mode default over one kernel release.

> For !McBSP2, it doesn't even pay to have the threshold mode at all, because
> the effect on PM is actually adverse - too frequent wakeups will cause more
> adverse net effect on PM (IIRC) @ VBAT.
> 
This is good information and integrating these functionalities allow to
collect more. Without regression of course :-)


-- 
Jarkko
