From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 1/6] ASoC: omap: simplify
	platform_get_resource_byname/devm_ioremap_resource
Date: Mon, 19 Aug 2013 21:02:33 +0300
Message-ID: <52125DB9.7040405@bitmer.com>
References: <1376902316-18520-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376902316-18520-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1376902316-18520-2-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

On 08/19/2013 11:51 AM, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Remove unneeded error handling on the result of a call to
> platform_get_resource_byname when the value is passed to devm_ioremap_resource.
> 
> In the case of omap-dmic.c, the error-handling code of
> devm_ioremap_resource is also corrected to include releasing the clock.
> 
> A simplified version of the semantic patch that makes this change is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression pdev,res,e,e1;
> expression ret != 0;
> identifier l;
> @@
> 
>   res = platform_get_resource_byname(...);
> - if (res == NULL) { ... \(goto l;\|return ret;\) }
>   e = devm_ioremap_resource(e1, res);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  sound/soc/omap/omap-dmic.c  |    9 +++------
>  sound/soc/omap/omap-mcpdm.c |    3 ---
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
To the patch and catch of missing clock release in omap-dmic.c in case
of failing devm_ioremap_resource:

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
