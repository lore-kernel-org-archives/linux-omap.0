From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: OMAP4: MCPDM: Remove unnecessary
 include of plat/control.h
Date: Tue, 12 Oct 2010 14:29:48 +0100
Message-ID: <20101012132948.GF30933@rakim.wolfsonmicro.main>
References: <1286890078-32610-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1286890078-32610-1-git-send-email-gadiyar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 12, 2010 at 06:57:58PM +0530, Anand Gadiyar wrote:
> Commit 346a5c890 (OMAP: control: move plat-omap/control.h
> to mach-omap2/control.h) in the linux-omap tree removed
> plat/control.h and most of its callers. This one slipped
> through - breaking the build as below when
> CONFIG_SND_OMAP_SOC_MCPDM is defined. Fix this.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
