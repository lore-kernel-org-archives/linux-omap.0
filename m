From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/2] omap: zoom: Move new code introduced
 by ASoC m-c to board-zoom-peripherals
Date: Fri, 24 Sep 2010 18:30:12 +0100
Message-ID: <1285349412.13240.42.camel@odin>
References: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
	<1285258314-23721-2-git-send-email-jhnikula@gmail.com>
	<C9D59C82B94F474B872F2092A87F26141272FF6109@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <C9D59C82B94F474B872F2092A87F26141272FF6109@dlee07.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <misael.lopez@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Pandita,
	Vikram" <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 2010-09-24 at 11:31 -0500, Lopez Cruz, Misael wrote:
> Hi Jarkko,
> 
> > ASoC Multi-Component Support moves some code from sound/soc/omap/zoom2.c
> > into
> > arch/arm/mach-omap2/board-zoom2.c. However, that code should go to
> > board-zoom-peripherals.c instead as there is common code and registration
> > for zoom boards.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > Cc: Vikram Pandita <vikram.pandita@ti.com>
> > Cc: Lopez Cruz, Misael <x0052729@ti.com>
> > Cc: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> > I don't have this HW so not tested.
> Tested on zoom2 using the 2 patches of your series, compilation break is
> gone and audio works fine.
> 
> Thanks,
> -Misael

Applied, and manually added your Tested-by:

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
