From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 3/3 v2] ASoC: add support for Amstrad
 E3 (Delta) machine
Date: Fri, 31 Jul 2009 13:58:41 +0200
Message-ID: <4A72DC71.6020904@tis.icnet.pl>
References: <200907291318.54897.jkrzyszt@tis.icnet.pl>
	<20090731095234.GB10844@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090731095234.GB10844@rakim.wolfsonmicro.main>
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

Mark Brown wrote:
> On Wed, Jul 29, 2009 at 01:18:53PM +0200, Janusz Krzysztofik wrote:
> 
>> 2) patch 2/3 form this series: TTY: Add definition of a new line
>>    discipline required by Amstrad E3 (Delta) ASoC driver[2].
> 
> The ASoC parts of this all look OK - what's the status of the TTY patch?
> 

Alan replied off-list yet before v2 submission. Then I replied him 
off-list as well... I hope he doesn't mind quoting him here.

Janusz Krzysztofik wrote:
> Alan Cox wrote:
>> Interesting use of a line discipline. The tty/ldisc bits look good to me
>>
> 
> Thanks.
> Could you please have a look at today's version 2 of the patch 3/3 as 
> well? The ldisc bits has been split into machine and codec related parts 
> and, what's more important, updated with locking that I am not quite 
> sure about its correctness.
> 
> Furthermore, I am still thinking about renaming the ldisc with a more 
> generic name. That way, it could be probably reused by other similiar 
> implementations. As long as the ldisc is registered from a board 
> specific code, it should not interfere with other implemnetations 
> reusing the same ldisc number, even if compiled in side by side.

Any objections on renaming ldisc from N_AMSDLETA to N_V253?

Thnaks,
Janusz
