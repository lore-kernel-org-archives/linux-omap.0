From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH RFC v4 2/8] ALSA: pcm: add IEC958
	channel	status helper for hw_params
Date: Mon, 21 Sep 2015 17:08:15 +0200
Message-ID: <56001D5F.1010903@ladisch.de>
References: <cover.1442572860.git.jsarha@ti.com>
 <a7b69fb075b0ae993846cfb65abb20ecab5c9805.1442572860.git.jsarha@ti.com>
 <20150921093748.GG21098@n2100.arm.linux.org.uk>
 <560016BE.6010801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <560016BE.6010801@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, moinejf@free.fr, airlied@linux.ie, broonie@kernel.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, Takashi Iwai <tiwai@suse.de>, tony@atomide.com, tomi.valkeinen@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Jyri Sarha wrote:
> On 09/21/15 12:37, Russell King - ARM Linux wrote:
>> ALSA documentation (which may be out of date) says that the hw_params
>> callback can be called multiple times during stream setup.  Do we want
>> to be repeatedly programming the HDMI infoframe with different settings,
>> potentially confusing the attached device, or would it be better to do
>> it slightly later (in the prepare callback) after the parameters have
>> been fully negotiated?
>
> If it is possible that hw_params() can be called multiple times, at
> least it does not happen very often. I wonder if it would ever happen
> again after a successful hw_params() call.

It is certainly allowed, and it happens regularly when using OSS
emulation.  AFAIK PulseAudio does something similar when enumerating
devices.

> But there is no downside in using prepare callback.

The prepare callback also can be called multiple times.  This certainly
happens when the stream is stopped/restarted multiple times.

If something does not need to be done again when a stream is restarted,
then it should be done in the hw_params callback.


Regards,
Clemens
