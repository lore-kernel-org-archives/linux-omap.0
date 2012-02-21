From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/3] MFD: twl6040: Conversion to i2c
	driver
Date: Tue, 21 Feb 2012 10:44:27 -0800
Message-ID: <20120221184427.GQ18185@atomide.com>
References: <1328868018-24668-1-git-send-email-peter.ujfalusi@ti.com>
	<20120220194736.GN5387@sortiz-mobl> <4F4372E3.4050408@ti.com>
	<20120221110533.GT5387@sortiz-mobl> <1329846755.20666.4.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1329846755.20666.4.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Liam Girdwood <lrg@ti.com> [120221 09:21]:
> On Tue, 2012-02-21 at 12:05 +0100, Samuel Ortiz wrote:
> > Hi Peter,
> > 
> > On Tue, Feb 21, 2012 at 12:33:07PM +0200, Peter Ujfalusi wrote:
> > > > I'm not sure hwo we could handle that properly. Either by letting Tony
> > > > carrying this patchset, or by sending me the panda patch that adds those
> > > > structures. As you prefer.
> > > 
> > > If Liam would take this series that would be probably the way forward.
> > > If he does not have objections.
> > > Liam: I can create a branch for you to pull from as soon as all other
> > > patch receives the needed acks...
> > > 
> > > Samuel: if Liam agrees is it possible for you to drop the twl6040
> > > related patches from your for-next branch?
> > That would make sense to me, yes.
> > Liam, if you're ok with taking it, please add my:
> > 
> > Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> > 
> 
> Ok, sounds fine by me. Tony is this fine wrt the OMAP board file
> updates ?

Yeah looks OK to me, acked that patch. Let me know if there are
others I should look.

Thanks,

Tony
