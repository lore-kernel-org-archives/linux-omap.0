From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: Re: [PATCHv4 2/7] ASoC: TWL6030: Add twl6030 codec
	driver
Date: Fri, 26 Feb 2010 13:42:35 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65E7E325@dlee06.ent.ti.com>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B14@dlee06.ent.ti.com>
	<1267007881.3274.136.camel@odin>
	<1889FA7136B567478A67D4B0F85B0CCE65DD22C9@dlee06.ent.ti.com>
	<20100225101710.GE10141@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100225101710.GE10141@rakim.wolfsonmicro.main>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Thursday, February 25, 2010 4:17 AM  Mark Brown wrote: 

>>> Are these two functions writing the default codec register values
>>> to the CODEC or are these non default (i.e. reset) values. If
>>> they are reset values is it not better to just issue the reset
>>> (and save the slow I2C writes) ?
> 
>> Yeap, but they write non default values to most of the registers.
> 
> Why are these non-default values being set?  The general style with
> things like this is that the register defaults listed in the
> driver are
> the physical defaults, and any explicit configuration is done with
> register writes.  This makes it clearer what's being changed and
> means that the actual register defaults are there for use if
> required. 
> 
> Normally only things that should be changed for all systems would be
> configured in this manner, things like audio paths which might
> change per system would be left for userspace to configure.
> 

I meant to say default values, sorry for the confusion

In TWL6040 codec, the registers belong to a power supply domain: VDD or VIO.
When the codec hits suspend state, VIO is not longer supplied, so registers
lose their values. However, VDD registers preserve their values as they belong
to a different power domain which still exist in suspend state. So when codec
resumes, it's only needed to restore VIO registers' values lost during suspend.
That's the reason why we have two separate functions to set VDD and VIO registers.
The former is only needed at probe time and the latter is needed every time codec
resumes.

At probe we are using the default values to keep the codec functional as many
features have not been enabled yet, some specific values are set using write
function.
