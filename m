From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH 0/4] ASOC: Add AM3517 EVM support in ASOC
Date: Fri, 29 Jan 2010 13:46:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E4F20BB@dbde02.ent.ti.com>
References: <1256842337-30334-1-git-send-email-anuj.aggarwal@ti.com>
	<20091029222933.GA7953@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091029222933.GA7953@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Friday, October 30, 2009 4:00 AM
> To: Aggarwal, Anuj
> Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org;
> tony@atomide.com
> Subject: Re: [alsa-devel] [PATCH 0/4] ASOC: Add AM3517 EVM support in ASOC
> 
> On Fri, Oct 30, 2009 at 12:22:17AM +0530, Anuj Aggarwal wrote:
> > This patch series add support for OMAP3517 / AM3517 EVM in ASOC.
> > It also enables the required drivers - I2C and McBSP, along with
> > Alsa SoC subsystem, in the default configuration for the EVM.
> >
> > Anuj Aggarwal (4):
> >   Audio: Adding OMAP3517 / AM3517 EVM support in ASOC
> >   Audio: Modifying Kconfig/Makefile for AM3517 EVM
> >   Audio: Modifying board-evm file for audio codec
> >   Audio: Modifying the defconfig for OMAP3517 / AM3517 EVM
> 
> These all look good - I've applied patches 1 and 2 to ASoC, patches 3
> and 4 should go via OMAP and are
Tony,

I could not find patches 3 & 4 on l-o master. Am I looking at the right 
branch?

> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> if it helps (or even if it doesn't!).  Thanks.
