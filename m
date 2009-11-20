From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure
 fix
Date: Fri, 20 Nov 2009 15:53:43 +0200
Message-ID: <20091120155343.baf0b9d3.jhnikula@gmail.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com>
	<bd7b27490911182334r7b9b4682o29a094e8ee521bc5@mail.gmail.com>
	<2ee9e08d0911191148x9da6112s960a283a7cffea7b@mail.gmail.com>
	<200911200951.13181.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200911200951.13181.peter.ujfalusi@nokia.com>
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
Cc: "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Wang,
	Jane" <jwang@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 20 Nov 2009 09:51:13 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > My question is: is sysfs the only way to choose threshold or can it be made
> >  as default? I could not see that happening in the code so thinking of the
> >  possible reason of choosing not to do so. Because the user who wants to
> >  hit suspend will not like to issue driver specific commands. Any specific
> >  reason of not doing that by default?
> 
> It is not selected as default on OMAP3, since it is a new feature, and we don't 
> want to change the behavior of the audio. If the reports are positive regarding 
> to the threshold mode, than we can make it as default on OMAP3, at least that is 
> the plan AFAIK. 

Yep. Currently we want to keep DMA behaviour consistent across the
OMAPs and McBSP ports since the large internal FIFO is found only
from McBSP2 on OMAP3.

This is good finding that you have found that it's the audio preventing
the suspend and the threshold transfer mode can make it hit better.

But anyway, I'm afraid that threshold mode doesn't help to create
robust suspend. Threshold allow the DMA and core to be mode in idle
between the FIFO fills and probably that's why suspend might work
during these idle periods. For robust implementation there must be
explicit code stopping and resuming all activity gracefully so that it
can hit the suspend also if the fill is happening or if using another
transfer mode.


-- 
Jarkko
