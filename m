From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 00/14] McBSP cleanup and generalization
Date: Wed, 07 Sep 2011 09:46:06 +0300
Message-ID: <2765628.C70gLzgCW7@barack>
References: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 31 August 2011 17:22:47 Jarkko Nikula wrote:
> Hi
> 
> Updates and continuation to my McBSP cleanup RFC set I sent before vacation
> period. Motivation here is to get rid off all is_omap and CONFIG_ARCH stuff
> and to make code a step more generic (and for preparing to move code out
> under arch/arm/).
> 
> I hope this version doesn't break OMAP1. I suppose it should work now as
> the register and dma addresses are calculated from common register numbers
> and not by mangling from OMAP2+ register offsets (Thanks for
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> for the idea).
> 
> Also MCBSP_CONFIG_TYPEx defines are not used to replace is_omap tests in
> plat/mcbsp.c in this version but by using a feature flags (Thanks for
> Charulatha V <charu@ti.com> for the idea).
> 
> Note that patch 01/14 has from address to my disabled google account. This
> is since the patch is already committed in to
> for_3.2/omap_device branch of Kevin's git tree.

These all looks good to me.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
