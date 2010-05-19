From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 3/4] ASoC: mcbsp - add machine threshold
 callback
Date: Wed, 19 May 2010 08:45:01 +0300
Message-ID: <20100519084501.1fdabbf6.jhnikula@gmail.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<1274213594-26554-4-git-send-email-lrg@slimlogic.co.uk>
	<2256F256009DAA4CBE661E9F41EAC84B9145EC6A@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B9145EC6A@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, 18 May 2010 15:56:46 -0500
"Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com> wrote:

> alsa-devel-bounces@alsa-project.org wrote:
> > Add a mechanism to register a machine specific callback
> > to calculate and set the McBSP Tx/Rx threshold.
> > 
...
> > +int omap_bcbsp_set_threshold_func(struct snd_soc_dai *cpu_dai,
> > +		void (*mach_set_threshold)(struct
> > snd_pcm_substream *substream));
> 
> Also here.
> 
Same comments, no any other objections but couple lines in commit log
would be nice have when machine would benefit from an own callback.
I.e. there could be boards that benefit from this.


-- 
Jarkko
