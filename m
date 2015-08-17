From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v3 2/7] ASoC: hdmi: Remove obsolete
	dummy HDMI codec
Date: Mon, 17 Aug 2015 10:00:07 +0300
Message-ID: <55D18677.3050805@ti.com>
References: <cover.1439542916.git.jsarha@ti.com>
 <360a38c83ae2a24620da85b8496b745326d995de.1439542916.git.jsarha@ti.com>
 <20150814161033.GT10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150814161033.GT10748@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, moinejf@free.fr, airlied@linux.ie, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, tomi.valkeinen@ti.com, bcousson@baylibre.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/14/15 19:10, Mark Brown wrote:
> On Fri, Aug 14, 2015 at 12:30:40PM +0300, Jyri Sarha wrote:
>> The hdmi stub codec has not been used since refactoring of OMAP HDMI
>> audio support.
>
> grep tells me that the OMAP HDMI4 and HDMI5 drivers are still
> registering this device in -next...
>

Really? My source trees for mainline and linux-next look like this:

$ git grep "hdmi-audio-codec"
sound/soc/codecs/hdmi.c:#define DRV_NAME "hdmi-audio-codec"

Don't you mean "omap-hdmi-audio", that is implemented in 
sound/soc/omap/omap-hdmi-audio.c ?

That driver is bit different. It implements ASoC card and uses generic 
dummy codec. The "hdmi-audio-codec" has not been used for OMAP HDMI 
audio for several releases already.

Best regards,
Jyri
