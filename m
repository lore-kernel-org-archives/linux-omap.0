From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v3 3/7] ASoC: hdmi-codec: Add
 hdmi-codec for external HDMI-encoders
Date: Mon, 17 Aug 2015 10:57:03 +0300
Message-ID: <55D193CF.5070605@ti.com>
References: <cover.1439542916.git.jsarha@ti.com>
 <ed41a6c0b594866c05e695cc066371d0e3862c7e.1439542916.git.jsarha@ti.com>
 <20150814161820.GU10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150814161820.GU10748@sirena.org.uk>
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

Missed one commet first time around...

On 08/14/15 19:18, Mark Brown wrote:
> On Fri, Aug 14, 2015 at 12:30:41PM +0300, Jyri Sarha wrote:
...
>> +/* HDMI codec initalization data */
>> +struct hdmi_codec_pdata {
>> +	struct device *dev; /* The HDMI encoder registering the codec */
>
> Shouldn't this just be dev->parent?
>

No. The HDMI encoder device is the parent for HDMI-codec.

The patch you took in in the last round uses the ASoC component drivers 
parent's of-node if the component driver does not have one itself. In 
this case the phandle in the binding points to the HDMI encoder's node, 
which is the parent of the HDMI codec.

Best regards,
Jyri
