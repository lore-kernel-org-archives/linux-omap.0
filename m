From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 7/7] ASoC: TWL6030: Power-up seq
 completion through audio interrupt
Date: Mon, 28 Sep 2009 14:37:21 +0100
Message-ID: <20090928133721.GF31899@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391E5@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90A391E5@dlee04.ent.ti.com>
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

On Fri, Sep 25, 2009 at 09:03:45PM -0500, Lopez Cruz, Misael wrote:

> -	0x41, /* TWL6030_INTMR		0x04	*/
> +	0x00, /* TWL6030_INTMR		0x04	*/

I suspect this should've been in the previous patch.

> -			/* power-up sequence latency */
> -			mdelay(16);
> +			/* wait for ready interrupt */
> +			wait_for_completion(&priv->ready_completion);

You should provide a timeout here, otherwise if there's a hardware
problem the driver will hang indefinitately waiting for the IRQ.
