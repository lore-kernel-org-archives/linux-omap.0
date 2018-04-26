From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/5] ARM: dts: omap2420-n810: Correct the
 audio codec (tlv320aic33) node
Date: Thu, 26 Apr 2018 21:15:27 +0300
Message-ID: <513d5300-8f4f-1f85-6e7d-e8c84368daab@bitmer.com>
References: <20180426115115.13744-1-peter.ujfalusi@ti.com>
 <20180426115115.13744-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180426115115.13744-3-peter.ujfalusi@ti.com>
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
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

On 04/26/18 14:51, Peter Ujfalusi wrote:
> The n810 uses tlv320aic33 codec.
> GPIO118 is used as reset GPIO for the codec, which was missing.
> The MCLK of the codec is connected to the SYS_CLKOUT2 of omap2420. The
> SYS_CLKOUT2 needs to be running at 12MHz.
> 
> Add the pinctrl entries to configure the pins for GPIO118 and SYS_CLKOUT2.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/boot/dts/omap2420-n810.dts | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
