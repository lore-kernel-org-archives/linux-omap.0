From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP: Exporting functions doing common
	register access
Date: Wed, 18 Nov 2009 16:33:14 +0200
Message-ID: <20091118163314.d0325283.jhnikula@gmail.com>
References: <1258384836-24854-1-git-send-email-anuj.aggarwal@ti.com>
	<alpine.DEB.2.00.0911161408260.29213@utopia.booyaka.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A8C8EC2@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A9CA8F7@dbde02.ent.ti.com>
	<alpine.DEB.2.00.0911180324350.25515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <alpine.DEB.2.00.0911180324350.25515@utopia.booyaka.com>
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
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 18 Nov 2009 03:40:40 -0700 (MST)
Paul Walmsley <paul@pwsan.com> wrote:

> In the interim, I would suggest that you remove the the clock source and 
> receiver source change functions from omap-mcbsp.c, split them into OMAP1 
> and OMAP2/3 variants, and place them into arch/arm/mach-omap*/mcbsp.c.  
> Expand struct omap_mcbsp_ops to add function pointers to those functions.  
> Call those from soc/omap-mcbsp.c via mcbsp->pdata->ops. That way you won't 
> need those exports.
> 
Paul: What's your opinnion, would it be possible or would it be wise to
handle these McBSP clock route setups with the clock framework instead?

Functions omap_mcbsp_dai_set_clks_src and omap_mcbsp_dai_set_rcvr_src
are basically just setting up the input clock for McBSP SRG or McBSP1
receiver.

> I don't understand how this code compiled on OMAP1 in any case, since it 
> doesn't have a System Control Module.
> 
OMAP1 can include control.h as well :-)

Access is anyway protected with the cpu_class_is_omap1().

-- 
Jarkko
