From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] ASoC: Add headset jack detection
	for	SDP3430 machine driver
Date: Fri, 6 Mar 2009 11:01:19 +0000
Message-ID: <20090306110116.GA6493@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705ECE137B9@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECE137B9@dlee07.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 05, 2009 at 11:32:31AM -0600, Lopez Cruz, Misael wrote:
> Add headset jack detection for SDP3430 boards using SoC jack
> reporting interface. Headset detection on SDP3430 board is
> achieved through TWL4030 GPIO_2 pin.

Applied, thanks.  One comment:

> +/* Headset jack detection gpios */
> +static struct snd_soc_jack_gpio hs_jack_gpios[] = {
> +	{
> +		.gpio = (OMAP_MAX_GPIO_LINES + 2),

It feels like there should be a nicer way of specifying the GPIO
number?
