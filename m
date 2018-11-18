From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/2] ASoC: omap-mcpdm: Add support for
 pdmclk clock handling
Date: Sun, 18 Nov 2018 19:06:37 +0200
Message-ID: <76dc8b4d-dcde-18a0-cc7b-4b18a4b82741@bitmer.com>
References: <20181114124631.4586-1-peter.ujfalusi@ti.com>
 <20181114124631.4586-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181114124631.4586-3-peter.ujfalusi@ti.com>
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
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/14/18 2:46 PM, Peter Ujfalusi wrote:
> McPDM module receives it's functional clock from external source. This
> clock is the pdmclk provided by the twl6040 audio IC. If the clock is not
> available all register accesses to McPDM fails and the module is not
> operational.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/omap-mcpdm.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
