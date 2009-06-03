From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Wed, 3 Jun 2009 09:24:12 +0200
Message-ID: <200906030924.14230.jkrzyszt@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl> <4A252A8E.9060602@tis.icnet.pl>
	<20090602203214.9edb786d.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090602203214.9edb786d.jhnikula@gmail.com>
Content-Disposition: inline
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
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Tuesday 02 June 2009 19:32:14 Jarkko Nikula wrote:
> > It is not clear for me if MCLK
> > is really used by the codec, or it is possible that it gets its
> > master clock from an other, modem related source, and if this does
> > really matter.
>
> Hmm. Are there any possibility that ams_delta_latch2_write requires
> working MCLK for latch change?

Looks like it doesn't. See below.

> Probably you could use also older implementation to find out is the
> MCLK required for codec by commenting out vc_mclk control.

Thanks! The origial driver with commented out clk_enable(vc_clk) and 
clk_disable(vc_clk) still works for me, so MCLK is not required! If I only 
knew what to do with this finding...

> Just hack the same "static struct omap_mcbsp_reg_cfg mcbsp_regs =
> { ..." in omap-mcbsp.c and pass that structure instead of
> &mcbsp_data->regs to omap_mcbsp_config in omap_mcbsp_dai_hw_params.

Done. Did not help. Again, I really don't know how to make use of this finding 
except for looking in a different place.

I tried to disassemble one of my deltas to get to those pins, but did not yet 
find a way to do it without breaking its case. I'll ask at E3-hacking list.

Thanks,
Janusz
