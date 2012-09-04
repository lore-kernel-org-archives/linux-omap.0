From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC update 0/2] dmaengine/ASoC: omap: Enable
	element mode in cyclic DMA
Date: Wed, 05 Sep 2012 00:37:30 +0200
Message-ID: <11245085.Nc6xDQ9liJ@acer>
References: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
 <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 4 Sep 2012 15:08:00 Peter Ujfalusi wrote:
> Hi Russell,
> 
> Enable the element mode (thus allowing mono playback and probably unblocking
> OMAP1, OMAP2420) in OMAP dmaengine and omap-pcm.
> 
> Janusz: would it be possible for you to test Russell's series plus this on
> OMAP1 to make sure that we do not broke it?

Hi Peter, Russell,
I'll be happy to make this test for you. This will take some time (I 
work away from home), but I expect to have it done by Monday.

BTW, I haven't been following OMAP development very closely last weeks, 
and I didn't even know about the OMAP DMA engine availability. Which 
Linux version should I base my test on? Would 3.6-rc be OK? Or l-o 
master?

Thanks,
Janusz
