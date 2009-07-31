From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] [PATCH 3/3 v2] ASoC: add support for Amstrad
 E3 (Delta) machine
Date: Fri, 31 Jul 2009 13:16:47 +0100
Message-ID: <20090731131647.012afb23@lxorguk.ukuu.org.uk>
References: <200907291318.54897.jkrzyszt@tis.icnet.pl>
	<20090731095234.GB10844@rakim.wolfsonmicro.main>
	<4A72DC71.6020904@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A72DC71.6020904@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Jonathan McDowell <noodles@earth.li>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, e3-hacking@earth.li, Arun KS <arunks@mistralsolutions.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> > Furthermore, I am still thinking about renaming the ldisc with a more 
> > generic name. That way, it could be probably reused by other similiar 
> > implementations. As long as the ldisc is registered from a board 
> > specific code, it should not interfere with other implemnetations 
> > reusing the same ldisc number, even if compiled in side by side.
> 
> Any objections on renaming ldisc from N_AMSDLETA to N_V253?

None
