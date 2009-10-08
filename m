From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] RX-51: Audio: Add usage of regulator
 framework to control VMMC2
Date: Thu, 8 Oct 2009 14:26:19 +0100
Message-ID: <20091008132619.GE29176@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-7-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1255003137-1034-7-git-send-email-eduardo.valentin@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 08, 2009 at 02:58:55PM +0300, Eduardo Valentin wrote:

> +static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
> +	REGULATOR_SUPPLY("avdd_dac", "2-0018"), /* tlv320aic3x */
> +	REGULATOR_SUPPLY("vdd", "2-0060"), /* tpa6130a2*/
>  };

avdd_dac is the only supply added for the tlv320aic3x but, for example,
the tlv320aic34 has something like 8 supplies from a quick scan of the
datasheet.  It'd be better to set up all of the supplies, even if only
with a fixed voltage regulator supplying them, since when regulator
support is added to the CODEC driver it should be requesting all the
supplies it needs and therefore fail to instatiate if some are missing.
