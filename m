From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] [PATCH 1/3] ASoC: Add support for
	Conexant	CX20442-11 voice modem codec
Date: Wed, 22 Jul 2009 11:10:28 +0100
Message-ID: <20090722101027.GA7622@sirena.org.uk>
References: <200907220522.29221.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200907220522.29221.jkrzyszt@tis.icnet.pl>
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
Cc: alsa-devel@alsa-project.org, Jonathan McDowell <noodles@earth.li>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, e3-hacking@earth.li, Arun KS <arunks@mistralsolutions.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 22, 2009 at 05:22:28AM +0200, Janusz Krzysztofik wrote:
> This patch adds support for Conexant CX20442-11 voice modem codec, suitable
> for use by the ASoC board driver for Amstrad E3 (Delta) videophone. Related
> sound card driver will follow.

> Created and tested against linux-2.6.31-rc3.
> Applies and works with linux-omap-2.6 commit
> 7c5cb7862d32cb344be7831d466535d5255e35ac as well.

> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

This patch is basically fine from an ASoC point of view so I've applied
it.

You'll want to run checkpatch over it and send a followup fixing the
issues it identifies.  Looking at this I suspect that it may be possible
to refactor things so that more of the line discipline interaction is
pushed down into the CODEC driver but that can also be done as a
followup.

Since this (and all the other descriptive text that follows it):

> This codec is an optional part of the Conexant SmartV three chip modem design.
> As such, documentation for its proprietary digital audio interface is not
> available. However, on Amstrad Delta board, thanks to Mark Underwood who

...is useful documentation I've pulled it into the commit message.  It
would also be nice to add some documentation somewhere explaining how
the hw_write() function is expected to be set up since it's a little
surprising (if the line discipline stuff were pushed down into the code
that'd become a lot more obvious).
