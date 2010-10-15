From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for
	2xxx devices
Date: Fri, 15 Oct 2010 09:51:09 +0300
Message-ID: <20101015095109.2d76babe.jhnikula@gmail.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
	<201010061017.13908.peter.ujfalusi@nokia.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CF14091@dbde02.ent.ti.com>
	<201010131131.49967.peter.ujfalusi@nokia.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D09A248@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030D09A248@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "Girdwood, Liam" <x0135381@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kamat, Nishant" <nskamat@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "ABRAHAM,
	KISHON VIJAY" <kishon@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 14 Oct 2010 20:21:15 +0530
"Varadarajan, Charulatha" <charu@ti.com> wrote:

> If other users should be allowed to use McBSP ports, it is good to
> have DMA support in plat-omap/mcbsp.c itself and modify the asoc
> implementation to take advantage of the proposed new mcbsp
> design. If agreed, this shall be addressed later. Please let
> me know your thoughts on this.
> 
ASoC design allows to have other data movers (ASoC platfrom driver)
also than SDMA only [1]. So tieing McBSP and DMA together means leaving
out DSP<->McBSP<->Codec setup.

I think API between McBSP driver and client should deal only with port
transfer setup and a layer above that should take care of data transfer
setup and implement an use-case specific API. E.g. where ALSA is using
continuous transmission from/to circular buffer some another use-case
would need chained scatter-gather DMA transfers, PIO, etc.

So things can get complicated if trying to implement generic transfer
API to general purpose block like McBSP compared to some dedicated
block where transfer setup is always more or less the same.


-- 
Jarkko
1.
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-August/030392.html
