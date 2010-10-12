From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: OMAP4: MCPDM: Remove unnecessary
 include of plat/control.h
Date: Tue, 12 Oct 2010 13:27:10 -0700
Message-ID: <20101012202710.GX25462@atomide.com>
References: <1286890078-32610-1-git-send-email-gadiyar@ti.com>
	<20101012132948.GF30933@rakim.wolfsonmicro.main>
	<20101012165142.6e9c6f94.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20101012165142.6e9c6f94.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Paul Walmsley <paul@pwsan.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Anand Gadiyar <gadiyar@ti.com>
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jhnikula@gmail.com> [101012 06:42]:
> On Tue, 12 Oct 2010 14:29:48 +0100
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > On Tue, Oct 12, 2010 at 06:57:58PM +0530, Anand Gadiyar wrote:
> > > Commit 346a5c890 (OMAP: control: move plat-omap/control.h
> > > to mach-omap2/control.h) in the linux-omap tree removed
> > > plat/control.h and most of its callers. This one slipped
> > > through - breaking the build as below when
> > > CONFIG_SND_OMAP_SOC_MCPDM is defined. Fix this.
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Tony, Liam: This must come via linux-omap together with other Paul's
> patches. Does not conflict with ASoC multi-component change.
> 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Thanks, adding into omap-for-linus.

Tony
