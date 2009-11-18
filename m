From: "Wang, Jane" <jwang@ti.com>
Subject: Re: [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure
	fix
Date: Wed, 18 Nov 2009 12:49:42 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039BB36BED@dlee02.ent.ti.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com>
	<20091114102024.b5c302bb.jhnikula@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A9CABBE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CABBE@dbde02.ent.ti.com>
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
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

> > Also context save/restore operations belongs more to PM callbacks
> > of .../plat-omap/mcbsp.c. Or probably that can be done also dynamically
> > inside the omap_mcbsp_start/-stop for keeping the whole McBSP shutdown
> > whenever it is idle.
> [Aggarwal, Anuj] I am sorry I couldn't understand that. Did you mean that
> PM hooks can be added in the mcbsp driver which can be registered and
> called
> As and when required? Any reference driver for this, if my understanding
> is correct?
> >
> > I think it's worth to look McBSP register cache concept [1] from Janusz
> > Krzysztofik would it help all of this context save/restore operations.
> [Aggarwal, Anuj] I tried these two patches on omap3 evm but they didn't
> work for me. The system doesn't go to the suspend state when I do:
> echo mem > /sys/power/state
> And the culprits were core (think sdma) and per domain. I tried
> disabling the mcbsp i/f clock as well but it didn't help. On mcbsp
> register dump, I couldn't find the sysconfig register getting
> configured. Could that be the root cause?

Did you include this patch?
http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=9da65a99e5e6a074c586474961dbf560e439df50

Without this patch, omap_stop_dma() did not disable DMA channel.


Regards,

-Jane
