From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: Configuring a TWL GPIO pin as an interrupt
Date: Mon, 23 Feb 2009 16:11:04 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705D632A0EE@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com>
	<200902202112.23307.david-b@pacbell.net>
	<2C7D3DF36ADFFC479B44490D912B616705D61AF093@dlee07.ent.ti.com>
	<200902222326.39232.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200902222326.39232.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: linux-omap@vger.kernel.org

> On Sunday 22 February 2009, Lopez Cruz, Misael wrote:
> > In the particular case of ALSA SoC, could the machine/board 
> > driver be a better place to handle all GPIO/IRQ configuration?
> > That driver also contains only board specific code.
> 
> It'd be best of the ASoC stuff could sit with all the other 
> board-specfic init code, in arch/*/mach-*/board-*.c files, 
> but I understand those interfaces are not yet stable enough 
> to support that ... that's why they're in sound/soc/*/*.c 
> files instead.
> 
> In any case ... everything I said still stands.  If you're 
> doing this for ASoC, you'll need some way to pass data to the 
> ASoC board-specific code from normal board-specific code, 
> since some of the relevant config data is not static.

I think that if I move the platform_device registration from machine driver to board file I can append jack detection information (gpio pin, irq) through "platform_data" of "dev" field in platform_device structure. And then in the "probe" part in ASoC machine driver I can receive it.

Could that be correct? Any other better/standard option?

> The current ASoC model seems to be biased towards static 
> configurations.  Notice how it's got to create its own 
> platform_device nodes ... it can't easily use the standard 
> mechanisms for associating platform_data or archdata with 
> those nodes, ditto clocks.
