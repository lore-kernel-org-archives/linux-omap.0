From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Wed, 05 Aug 2009 15:26:47 +0200
Message-ID: <4A798897.5000904@tis.icnet.pl>
References: <200908030332.06727.jkrzyszt@tis.icnet.pl>	<4A76ED80.6040001@tis.icnet.pl>	<20090803181405.6249b843.jhnikula@gmail.com>	<200908042246.09919.jkrzyszt@tis.icnet.pl>	<20090805102149.bfcafa35.jhnikula@gmail.com>
	<20090805114254.02e3d0e2.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090805114254.02e3d0e2.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Arun K S <arunks@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Jarkko Nikula wrote:
> On Wed, 5 Aug 2009 10:21:49 +0300
> Jarkko Nikula <jhnikula@gmail.com> wrote:
> 
>>> If my analysis is correct, the best solution I can see would be starting McBSP 
>>> transfer for one direction only, not both, so the opposite direction can be 
>>> started when needed. That requires deeper and wider OMAP knowledge and a 
>>> change in omap_mcbsp_start() API though. I am not in a position to deal with 
>>> this myself, I'm afraid.
>>>
>> I favor this change. Actually I remember I was thinking shortly to
>> change API of omap_mcbsp_start and _stop more than year back or so but
>> didn't find it necessary back then.
>>
>> I think change will be trivial. Basically two new arguments indicating
>> are the TX/RX active and let the first/last caller to deal with
>> sample-rate generator and frame sync activation/de-activation.
>>
> I hacked a patch below. Can you test does it help?

Will do tonight (CET).

Now seeing how easy it was (for you ;), I think I could try to follow 
that way an modify omap_mcbsp_config() in the same spirit, if you find 
it of any use.

Cheers,
Janusz
