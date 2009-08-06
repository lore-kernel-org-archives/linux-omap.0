From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Thu, 6 Aug 2009 11:30:29 +0200
Message-ID: <200908061130.30804.jkrzyszt@tis.icnet.pl>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl>
	<200908042246.09919.jkrzyszt@tis.icnet.pl>
	<200908050945.22160.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200908050945.22160.peter.ujfalusi@nokia.com>
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
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arun K S <arunks@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Wednesday 05 August 2009 08:45:21 Peter Ujfalusi wrote:
> In case of playback start while capture: What is the state of the XEMPTY
> bit (SPCR2:2)? Is it 0? It should.

Yes, XEMPTY was 0, both before and after omap_start_dma().

For completness of the record:
RFULL was 1 (again as expected) in case of capture start while playing.

Janusz
