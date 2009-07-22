From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 1/3] ASoC: Add support for Conexant
 CX20442-11 voice modem codec
Date: Wed, 22 Jul 2009 16:01:43 +0200
Message-ID: <4A671BC7.20300@tis.icnet.pl>
References: <200907220522.29221.jkrzyszt@tis.icnet.pl>
	<20090722101027.GA7622@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090722101027.GA7622@sirena.org.uk>
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

Hi Mark,

Mark Brown wrote:
> On Wed, Jul 22, 2009 at 05:22:28AM +0200, Janusz Krzysztofik wrote:
>> This patch adds support for Conexant CX20442-11 voice modem codec, suitable
>> for use by the ASoC board driver for Amstrad E3 (Delta) videophone. Related
>> sound card driver will follow.
>> ...
> This patch is basically fine from an ASoC point of view so I've applied
> it.

Thanks!

> You'll want to run checkpatch over it and send a followup fixing the

Sorry for not doing this before submitting. Will send the followup soon.

> issues it identifies.  Looking at this I suspect that it may be possible
> to refactor things so that more of the line discipline interaction is
> pushed down into the CODEC driver but that can also be done as a
> followup.

I have put the line discipline code into the machine driver for two reasons:
1. For me, the actual code is much more machine than codec specific.
2. It was much easier to update the codec structure instance with 
machine's provided hw_write() rather than fiddle with adding a new 
member to the structure definition for passing a machine callback to the 
line discipline functions.

If you think we can find any use cases for drivers supporting 
codec/modem combination other than CX20442 on Amstrad Delta, I can agree 
with you on moving the line discipline code out of the machine driver, 
but instead of pushing it down to the codec I would rather se it as a 
separate module.  Anyway, I think that some kind of support on the ASoC 
top level for this case could be helpfull.

> would also be nice to add some documentation somewhere explaining how
> the hw_write() function is expected to be set up since it's a little
> surprising (if the line discipline stuff were pushed down into the code
> that'd become a lot more obvious).

I'll add a few words to the followup.

Thanks,
Janusz
