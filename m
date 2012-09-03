From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 1/3] ASoC: dmaengine: Don't use
 runtime	private data for dmaengine data
Date: Mon, 03 Sep 2012 22:59:54 +0200
Message-ID: <50451A4A.9000108@metafoo.de>
References: <20120903165832.GA31511@n2100.arm.linux.org.uk>
 <E1T8ZzV-0002vp-2j@rmk-PC.arm.linux.org.uk> <5045124D.3050604@metafoo.de>
 <20120903204325.GA728@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120903204325.GA728@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/03/2012 10:43 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 03, 2012 at 10:25:49PM +0200, Lars-Peter Clausen wrote:
>> On 09/03/2012 06:59 PM, Liam Girdwood wrote:
>>> Use a dedicated member to store dmaengine data so that drivers can
>>> use private data for their own purposes.
>>>
>>
>> The idea was that we'll eventually get to a point where we won't need private
>> data for the drivers using the generic dmaengine code. But for the transitional
>> period there is snd_dmaengine_pcm_{set,get}_data which allows to attach driver
>> private data to the dmaengine pcm. For an example see how the other users of
>> dmaengine pcm handle this.
> 
> That's fine if you are writing new drivers from scatch, or know the
> driver you're converting inside-out.  Neither applies here (I've
> struggled to do anything with the OMAP audio stuff for many many
> reasons.)
> 
> I rather wish that people who did know the OMAP ASoC driver had stepped
> up to this conversion, but alas they haven't.
> 
> In any case, if you want people to use the this soc-dmaengine helper
> then you have to make the conversion to it simple, and requiring
> everyone to totally restructure their drivers to use it does not make
> that process simple.
> 
> What you have here is the result of several transformations to the
> driver, which would _not_ have been possible without this first patch
> from Liam.

Ok, it might have been helpful in the conversion process, but for the final
patch it would be nice if you could replace

struct snd_pcm_runtime *runtime = substream->runtime;
struct omap_runtime_data *prtd = runtime->private_data;
struct omap_pcm_dma_data *dma_data = prtd->dma_data;
with
struct omap_pcm_dma_data *dma_data = snd_dmaengine_pcm_get_data(substream);

and in the hwparams callback use

snd_dmaengine_pcm_set_data(substream, dma_data);

and then drop patch 1 and 2 from the series.
