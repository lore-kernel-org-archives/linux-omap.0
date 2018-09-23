From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2PLUS: Remove references to
 AM3517-EVM since it's in DT
Date: Sun, 23 Sep 2018 19:23:58 +0300
Message-ID: <adbc42d6-efae-20cf-64a2-994ccdffcd87@bitmer.com>
References: <20180923153718.15095-1-aford173@gmail.com>
 <20180923153718.15095-3-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180923153718.15095-3-aford173@gmail.com>
Content-Language: en_US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Ford <aford173@gmail.com>, linux-omap@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/23/18 18:37, Adam Ford wrote:
> Since the audio codecs used on the AM3517-EVM are now available
> in device tree, and the audio driver wasn't really being used
> anyway, this patch removes the remaining AM3517 legacy board
> options and sound soc drivers.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
For sound/soc/omap/ changes:

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
