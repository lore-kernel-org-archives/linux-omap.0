From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v4 2/8] ALSA: pcm: add IEC958 channel
 status helper for hw_params
Date: Mon, 21 Sep 2015 17:39:58 +0300
Message-ID: <560016BE.6010801@ti.com>
References: <cover.1442572860.git.jsarha@ti.com>
 <a7b69fb075b0ae993846cfb65abb20ecab5c9805.1442572860.git.jsarha@ti.com>
 <20150921093748.GG21098@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150921093748.GG21098@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, moinejf@free.fr, airlied@linux.ie, tomi.valkeinen@ti.com, Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/21/15 12:37, Russell King - ARM Linux wrote:
> On Fri, Sep 18, 2015 at 02:06:39PM +0300, Jyri Sarha wrote:
>> Add IEC958 channel status helper that gets the audio properties from
>> snd_pcm_hw_params instead of snd_pcm_runtime. This is needed to
>> produce the channel status bits already in audio stream configuration
>> phase.
>
> What is the reason for doing this early?
>

After some thinking, there is no good reason. It makes the codec bit 
more complicated, but that is not a good reason. I'll change that and 
use the prepare callback.

This patch can be dropped.

> ALSA documentation (which may be out of date) says that the hw_params
> callback can be called multiple times during stream setup.  Do we want
> to be repeatedly programming the HDMI infoframe with different settings,
> potentially confusing the attached device, or would it be better to do
> it slightly later (in the prepare callback) after the parameters have
> been fully negotiated?
>

If it is possible that hw_params() can be called multiple times, at 
least it does not happen very often. I wonder if it would ever happen 
again after a successful hw_params() call. But there is no downside in 
using prepare callback. I was just too much following the way ASoC 
codecs usually do the thing by writing everything to iron as the 
callbacks come in.

Best regards,
Jyri
