From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/30] ARM: omap2/n8x0: work around modular omap mmc
Date: Sun, 02 Oct 2011 20:54:58 +0200
Message-ID: <1412062.DNcqS3fczZ@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-12-git-send-email-arnd@arndb.de>
	<20111002155331.GA12323@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111002155331.GA12323@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sunday 02 October 2011 16:53:31 Russell King - ARM Linux wrote:
> On Sun, Oct 02, 2011 at 04:45:41PM +0200, Arnd Bergmann wrote:
> > -#if defined(CONFIG_MENELAUS) &&                                              \
> > -     (defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE))
> > +#if defined(CONFIG_MENELAUS) && defined(CONFIG_MMC_OMAP)
> > +/* || defined(CONFIG_MMC_OMAP_MODULE)) */
> > +/* FIXME: cannot call omap_mmc_notify_cover_event for ONFIG_MMC_OMAP_MODULE */
> 
> #ifdef CONFIG_MMC_OMAP_MODULE
> #warning FIXME: cannot call omap_mmc_notify_cover_event for CONFIG_MMC_OMAP_MODULE
> #endif
> #if defined(CONFIG_MENELAUS) && defined(CONFIG_MMC_OMAP)
> 
> So that it can be seen at build time?
> 
> Also note the 'ONFIG' typo...

Ok, good idea. I've updated the patch in the git tree accordingly.

Depending on what Tony wants, I might send out the entire series
again once there are no more new comments.

	Arnd
