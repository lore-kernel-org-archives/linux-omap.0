From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 8/9] OMAP4: omap4panda: Enable audio
	support
Date: Thu, 22 Dec 2011 13:24:27 +0000
Message-ID: <20111222132426.GS4546@opensource.wolfsonmicro.com>
References: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com>
	<1324557768-8216-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1324557768-8216-9-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 22, 2011 at 02:42:47PM +0200, Peter Ujfalusi wrote:

> +static void omap4_panda_audio_init(void)
> +{
> +	if (cpu_is_omap4430()) {
> +		/* PandaBoard 4430 */
> +		panda_abe_audio_data.card_name = "PandaBoard";
> +		/* Audio in is connected to HSMIC */
> +		panda_abe_audio_data.has_hsmic = 1;
> +	} else {
> +		/* PandaBoard ES */
> +		panda_abe_audio_data.card_name = "PandaBoardES";

Is audio the only difference between the two boards?  If there's more
stuff it might be more sensible to have a single place which decides
what the differences are rather than scattering it in various places.
