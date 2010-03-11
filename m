From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 0/5] FIFO caused playback delay (latency)
	handling in soc/omap
Date: Thu, 11 Mar 2010 22:43:41 +0000
Message-ID: <186E584F-F553-44F0-A49D-361BB76E0EE4@opensource.wolfsonmicro.com>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100303133806.GA15105@sirena.org.uk>
	<20100311222655.GP2900@atomide.com>
	(sfid-20100311_222542_077523_F5624C8B)
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100311222655.GP2900@atomide.com>
	(sfid-20100311_222542_077523_F5624C8B)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On 11 Mar 2010, at 22:26, Tony Lindgren <tony@atomide.com> wrote:

> * Mark Brown <broonie@opensource.wolfsonmicro.com> [100303 05:34]:
>> On Wed, Mar 03, 2010 at 03:08:03PM +0200, Peter Ujfalusi wrote:
>>
>>> Peter Ujfalusi (5):
>>>  ASoC: core: fix tailing whitespace in soc_pcm_apply_symmetry
>>>  ASoC: core: soc level wrapper for pcm_pointer callback
>>>  ASoC: core: Add delay operation to snd_soc_dai_ops
>>
>> I'll apply these just now, thanks!
>>
>>>  OMAP3: McBSP: Add interface for FIFO caused delay query
>>>  ASoC: OMAP3: Report delay caused by the internal FIFO
>>
>> These also look OK to me but there's the arch/arm dependency.
>
> I think the only one is the McBSP patch above.
>
> Care to take that too to keep things working?
>
> Acked-by: Tony Lindgren <tony@atomide.com>

I can do, though there was some debate about how useful the  
information the hardware returns actually is - could folks confirm  
what the consensus there was, please?
