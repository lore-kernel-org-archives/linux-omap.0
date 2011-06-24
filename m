From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [RFC 5/8] remoteproc: add davinci implementation
Date: Fri, 24 Jun 2011 21:13:49 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2F29@dbde02.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-6-git-send-email-ohad@wizery.com>
	<4E035B78.3080200@mvista.com>
	<FFF198FBBF957F4393BA834040FEFFA202D66E@DFLE35.ent.ti.com>
	<4E04A9AE.3030801@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E04A9AE.3030801@mvista.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sshtylyov@mvista.com>, "Grosen, Mark" <mgrosen@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Arnd Bergmann <arnd@arndb.de>, Brian Swetland <swetland@google.com>, Rusty Russell <rusty@rustcorp.com.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Fri, Jun 24, 2011 at 20:43:50, Sergei Shtylyov wrote:

> >>> +	rproc->priv = dsp_clk;
> >>> +
> >>> +	psc_base = ioremap(soc_info->psc_bases[0], SZ_4K);
> >>> +
> >>> +	/* insure local reset is asserted before writing start address */
> >>> +	__raw_writel(NEXT_ENABLED, psc_base + MDCTL + 4 *
> >> DA8XX_LPSC0_GEM);
> >>> +
> >>> +	__raw_writel(bootaddr, DA8XX_SYSCFG0_VIRT(HOST1CFG));
> 
> >>     DA8XX_SYSCFG0_VIRT() is not supposed to be used outside mach-davinci. The
> >> variable it refers is not exported, so driver module won't work.
> 
> > Ooops, I clearly did not build this as a module. Suggestion how to fix this?
> 
>     Using the normal ioremap() of SYSCFG0 space, I suppose.

Since procedure to set the boot address varies across DaVinci
platforms, you could have a callback populated in platform data
which will be implemented differently for original DaVinci and
DA8xx devices.

Also, all PSC accesses are better off going through clock
framework to ensure proper locking and modularity.

To assert/de-assert local reset when enabling or disabling PSC,
you could use a flag in the clock structure to indicate the need
for this. This way, if there is any other module needing a local
reset, it can just define the same flag. Similarly, if the DSP
does not need a local reset on a particular platform, that
platform can simply skip the flag.

This can be done in a manner similar to how the support for
a forced transition PSC was added here:

https://patchwork.kernel.org/patch/662941/

Thanks,
Sekhar
