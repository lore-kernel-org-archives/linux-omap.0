From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in v5.0-rc with regmap-irq level-irq changes
Date: Tue, 15 Jan 2019 16:10:25 -0800
Message-ID: <20190116001025.GL5544@atomide.com>
References: <20190115192840.GK5544@atomide.com>
 <20190115210920.GJ5522@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115210920.GJ5522@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Belisko Marek <marek.belisko@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Jon Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [190115 21:09]:
> On Tue, Jan 15, 2019 at 11:28:40AM -0800, Tony Lindgren wrote:
> 
> > Any ideas what's needed? Some triggering mapping data to palmas.c
> > driver?
> 
> There should be a fix in -next already waiting for me to send it to
> Linus, can you check there (a couple actually, in my for-linus branch)?

OK great, yes the two drivers/base/regmap patches fix the issue
for me.

Regards,

Tony
