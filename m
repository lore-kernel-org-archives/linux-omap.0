From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 1/3] ASoC: Add support for Conexant
	CX20442-11 voice modem codec
Date: Tue, 28 Jul 2009 18:36:01 +0200
Message-ID: <200907281836.03049.jkrzyszt@tis.icnet.pl>
References: <200907220522.29221.jkrzyszt@tis.icnet.pl>
	<200907281807.31070.jkrzyszt@tis.icnet.pl>
	<20090728161131.GA22349@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090728161131.GA22349@rakim.wolfsonmicro.main>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jonathan McDowell <noodles@earth.li>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, e3-hacking@earth.li, Arun KS <arunks@mistralsolutions.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

Tuesday 28 July 2009 18:11:32 Mark Brown wrote:
> On Tue, Jul 28, 2009 at 06:07:29PM +0200, Janusz Krzysztofik wrote:
> > now. Activation of the line discipline would deregister the codec device
> > from the platform bus and reregister it again, now as the line discipline
> > provided device. Is this possible with current ASoC framework?
>
> No, not currently.  But why would you do that, anyway?
>
> Like I say, I'd suggest always keeping the controls registered and just
> masking and unmasking from user space - the control indexes get used so
> removing them will just confuse things.

However, in order for the machine driver to unmask/mask a machine specific 
control, the codec driver must drop the machine driver a message about the 
line discipline being activeted/deactivated, right? The only such existing 
feedback I can see the codec is able to use is via snd_soc_init_card() that 
calls snd_soc_dai_link.init() in turn. Am I missing something?

Janusz
