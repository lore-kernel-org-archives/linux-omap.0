From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2/4] OMAP: mcbsp - add smart idle
	configuration API
Date: Wed, 19 May 2010 08:22:45 +0300
Message-ID: <20100519082245.b51fc5bc.jhnikula@gmail.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<1274213594-26554-3-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1274213594-26554-3-git-send-email-lrg@slimlogic.co.uk>
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

On Tue, 18 May 2010 21:13:12 +0100
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> Add a small API to configure McBSP smart idle modes
> to conserve power.
> 
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  arch/arm/plat-omap/include/plat/mcbsp.h |   15 ++++
>  arch/arm/plat-omap/mcbsp.c              |  122 +++++++++++++++++++++++++++++++
>  2 files changed, 137 insertions(+), 0 deletions(-)
> 
> +#define MCBSP_IDLE_FORCE	0
> +#define MCBSP_IDLE_NONE		1
> +#define MCBSP_IDLE_SMART	2
> +
...
> +int omap_mcbsp_set_idle_smart(unsigned int id, unsigned int clk_activity,
> +		unsigned int wake);
> +int omap_mcbsp_set_idle_none(unsigned int id);
> +int omap_mcbsp_set_idle_force(unsigned int id);
> +int omap_mcbsp_get_idle_mode(unsigned int id);

Only minor comment but IMO single set function looks better. E.g.

omap_mcbsp_set_idle_mode(unsigned int id, int mode);


-- 
Jarkko
