From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/4] McBSP smart idle and DMA op mode
	updates for ASoC
Date: Wed, 19 May 2010 08:13:25 +0300
Message-ID: <20100519081325.6e341075.jhnikula@gmail.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 18 May 2010 21:13:10 +0100
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> I've also added a patch to remove the mcbsp DMA op mode sysfs set functionality.
> I think DMA op mode is very specific to the mcbsp client driver _only_ and
> shouldn't really be changed by userspace. Please let me know if you use this
> feature and I'll drop this patch.
> 
I've used to say that the DMA op mode is more like use-case not machine
specific but I'm not sure is my point valid onemore. I've used to think
that low-latency processing would need accurate DMA pointer (op
mode == element) while mp3 playback would need low power consumption
(op mode == threshold).

Peter: what's the status today how well can we do low-latency
processing with threshold mode? IRCC, with your FIFO delay query
patches, can we estimate the DMA pointer position with enough accuracy?


-- 
Jarkko
