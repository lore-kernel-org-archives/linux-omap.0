From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 16/20] ASoC: OMAP: Use McBSP threshold again
Date: Tue, 11 Aug 2009 08:34:45 +0300
Message-ID: <20090811083445.3d5ee595.jhnikula@gmail.com>
References: <1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-14-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-15-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-16-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-17-git-send-email-eduardo.valentin@nokia.com>
	<20090805104856.ff3e0f31.jhnikula@gmail.com>
	<20090810085355.GA23461@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090810085355.GA23461@esdhcp037198.research.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 10 Aug 2009 11:53:55 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> > Oops, didn't notice this before. This will hard glue the DMA and McBSP
> > together. Even currently there is only McBSP based DAI link driver,
> > there can be others as well. EAC DAI for OMAP2420 would be necessary
> > for instance if one wants to develop ASoC support for Nokia N800. Nokia
> > N810 could use that too.
> 
> True. And the same comment is valid for the patch which adds op mode selection.
> My idea to un-glue them is to put some callbacks in omap_mcbsp_data of omap-mcbsp.c,
> and share it as something more generic, so that they can be called from omap-pcm.c.
> 
> Something like:
> 
> struct omap_dma_data {
> 	unsigned int			bus_id;
> 	unsigned int			fmt;
> 	/*
> 	 * Flags indicating is the bus already activated and configured by
> 	 * another substream
> 	 */
> 	int				active;
> 	int				configured;
> 	/* threshold callbacks can be added then here */
> 	void				*data; /* struct omap_mcbsp_reg_cfg	regs; can go here */
> };
> 
> And this goes in omap-pcm.h.
> 
> what do you think??
> 
I'm thinking is it just enough to share sync_mode between the
omap-pcm.c and omap-mcbsp.c? For me it looks that both period_bytes_max
(by using snd_pcm_hw_constraint_minmax) adjustment and threshold
setting can be done in omap-mcbsp.c. Then there is no need to invent
any callbacks to the omap_dma_data (for now) and omap-pcm.c remains
cleanear as the threshold is not so much DMA programming specific.


-- 
Jarkko
