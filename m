From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/5 v2] ASoC Add TLV320AIC23 codec driver
Date: Thu, 2 Oct 2008 11:15:28 +0100
Message-ID: <20081002101524.GF2848@sirena.org.uk>
References: <dfeb90390810020225h2e5e33a5jc4b71816bda0c21e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <dfeb90390810020225h2e5e33a5jc4b71816bda0c21e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com, troy.kisky@boundarydevices.com
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 02, 2008 at 02:55:27PM +0530, Arun KS wrote:
> ASoC codec driver for TLV320AIC23 device

> Signed-off-by: Arun KS <arunks@mistralsolutions.com>

This looks good and it's probably as well to merge it now since the one
issue below is mostly cosmetic so if nothing else it'll be easier to
review incrementally so:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> +static const char *deemph_text[] = {"None", "32Khz", "44.1Khz", "48Khz"};
> +static const char *sidetone_text[] = {"-6db", "-9db", "-12db", "-18db", "0db"};

...

> +static const struct soc_enum tlv320aic23_sidetone =
> +	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 6, 5, sidetone_text);

...

> +	SOC_ENUM("Sidetone Gain", tlv320aic23_sidetone),

As I said on the last submission this should really be a SOC_SINGLE_TLV
called "Sidetone Volume" rather than an enumeration - it's a dB scale
controlling gain rather than an enumeration.
