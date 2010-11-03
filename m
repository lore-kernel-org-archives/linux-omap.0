From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1
	compilation problem
Date: Wed, 3 Nov 2010 10:20:28 +0200
Message-ID: <20101103102028.8ff19cac.jhnikula@gmail.com>
References: <201011021550.34885.jkrzyszt@tis.icnet.pl>
	<alpine.DEB.2.00.1011021058380.22589@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <alpine.DEB.2.00.1011021058380.22589@utopia.booyaka.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Walmsley <paul@pwsan.com>
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, e3-hacking@earth.li, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, 2 Nov 2010 10:58:59 -0600 (MDT)
Paul Walmsley <paul@pwsan.com> wrote:

> On Tue, 2 Nov 2010, Janusz Krzysztofik wrote:
> 
> > In the new code introduced with commit cf4c87abe238ec17cd0255b4e21abd949d7f811e,
> > "OMAP: McBSP: implement McBSP CLKR and FSR signal muxing via mach-omap2/mcbsp.c",
> > the way omap1 build is supposed to bypass omap2 specific functionality doesn't 
> > optimize out all omap2 specific stuff. This breaks linking phase for omap1 
> > machines, giving "undefined reference to `omap2_mcbsp1_mux_clkr_src'" 
> > and "undefined reference to `omap2_mcbsp1_mux_fsr_src'" errors. Fix it.
> > 
> > Created and tested against linux-2.6.37-rc1.
> > 
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> Thanks Janusz.
> 
Yep, this must go to 2.6.37.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
