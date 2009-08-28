From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Audio capture not working with AIC23/McBSP1 on
 OMAP3517
Date: Fri, 28 Aug 2009 13:51:03 +0300
Message-ID: <20090828135103.63ca2343.jhnikula@gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D82D@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0309E9DB24@dbde02.ent.ti.com>
	<20090827141253.9f772f31.jhnikula@gmail.com>
	<200908280955.01382.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200908280955.01382.peter.ujfalusi@nokia.com>
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
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 28 Aug 2009 09:55:01 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > Can you, Peter or who has access to 2420 and 2430 TRMs to verify is the
> > DEVCONF0 bits 3 and 4 selecting there also the McBSP1 CLKR and FSR
> > sources like my patch is now assuming for all OMAP2-3.
> 
> On OMAP2:
> DEVCONF:3 MCBSP1_CLKR
> DEVCONF:4 MCBSP1_FSR
> 
> So it is correct for  both OMAP2 and OMAP3.
> 
Good :-)

Are you Mark fine with the patch [] where the snd_soc_dai_set_sysclk
is used to specify source pin for CLKR and FSR?


-- 
Jarkko

1.
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-August/020771.html
