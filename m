From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Wed, 31 Aug 2016 10:42:19 -0700
Message-ID: <20160831174219.jy3okyjgomyotax5@atomide.com>
References: <20160829182746.53vrgbxadqodzzug@atomide.com>
 <201608300739.JrTVlIyd%fengguang.wu@intel.com>
 <20160830183834.6u73eb5ujgm5emlk@atomide.com>
 <20160831172440.GA7866@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20160831172440.GA7866@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, kbuild test robot <lkp@intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, kbuild-all@01.org, Pavel Machel <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [160831 10:25]:
> On Tue, Aug 30, 2016 at 11:38:35AM -0700, Tony Lindgren wrote:
> 
> > Updated patch below, Mark let me know if you need an incremental
> > patch to fix the warning.
> > 
> > Regards,
> > 
> > Tony
> > 
> > 8< -----------------
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Mon, 29 Aug 2016 11:27:46 -0700
> > Subject: [PATCHv2] ASoC: omap-mcbsp: Add PM QoS support for McBSP to prevent
> 
> Please send the patch normally rather than burying it in the middle of
> another e-mail :(

OK will resend after hearing back comments from Peter.

Tony
