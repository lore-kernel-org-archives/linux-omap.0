From: Illia Smyrnov <x0194613@ti.com>
Subject: Re: [PATCH v3 2/2] spi: omap2-mcspi: Add FIFO buffer support
Date: Mon, 17 Jun 2013 16:39:02 +0300
Message-ID: <51BF1176.7070608@ti.com>
References: <1371226328-24147-1-git-send-email-illia.smyrnov@ti.com> <1371226328-24147-3-git-send-email-illia.smyrnov@ti.com> <20130617091630.GZ1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130617091630.GZ1403@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Illia Smyrnov <illia.smyrnov@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Daniel Mack <zonque@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 06/17/2013 12:16 PM, Mark Brown wrote:
> On Fri, Jun 14, 2013 at 07:12:08PM +0300, Illia Smyrnov wrote:
>> The MCSPI controller has a built-in FIFO buffer to unload the DMA or interrupt
>> handler and improve data throughput. This patch adds FIFO buffer support for SPI
>> transfers in DMA mode.
>
> This looks good but doesn't apply against my topic/omap branch - can you
> please check and resend?  Probably something that applies against -next
> will be fine.
>

I fixed it and sent v4 of "spi: omap2-mcspi: Add FIFO buffer support" patch.
