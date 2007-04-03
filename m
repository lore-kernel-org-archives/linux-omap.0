From: tony@atomide.com
Subject: Re: [patch 2.6.21-rc5-git] omap_cf oops-in-suspend fix
Date: Tue, 3 Apr 2007 15:48:14 -0400
Message-ID: <20070403194813.GC24864@atomide.com>
References: <200704021251.48245.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <200704021251.48245.david-b@pacbell.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pcmcia@lists.infradead.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070402 16:44]:
> Convert omap_cf into a platform_driver ... this resolves oopsing during
> suspend/resume.
> 
> Evidently folk haven't tried suspend/resume on an OSK (the main platform
> for this driver) since September or so, which is when platform_device
> learned about suspend_late()/resume_early() and stopped being able to
> suspend/resume without a having a real platform_driver.

FYI, while waiting for this to get integrated to Linus' tree, I've pushed
it to linux-omap tree.

Regards,

Tony
