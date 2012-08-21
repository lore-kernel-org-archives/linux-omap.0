From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [RFC] ASoC: snd_soc_jack for HDMI audio: does it make
	sense?
Date: Mon, 20 Aug 2012 20:47:17 -0500
Message-ID: <5032E8A5.8070108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, "Brown, Mark" <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, "Valkeinen,
 Tomi" <tomi.valkeinen@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello!

I have been working on prototypes for the ASoC OMAP HDMI audio driver to 
propagate events from the HDMI output (e.g., display getting 
enabled/disabled/suspended). This for the users of the driver to react 
to such events. For instance, if the display is disabled or disconected, 
audio could be stopped, rerouted or whatever other decision the user 
makes. This is needed because, if, for instance, the  HDMI IP goes off, 
audio will stall and the audio users will only see a "playback write 
error (DMA or IRQ trouble?)"

In my prototypes I have used snd_soc_jack for this purpose and I have 
some questions:

*I see snd_soc_jack is used mostly for headsets and microphones with 
actual external mechanical connections. Strictly, in my case I propagate 
events originated by the OMAP display driver (changes in the power 
state), and not from external events. Some of these events are generated 
from an actual HDMI cable connection/disconnection, though.

*Maybe the event should be propagated by omapdss/omapdrm/drm and the 
entity in charge of the audio policy should listen those events instead.

*I do see SND_JACK_VIDEOOUT and SND_JACK_AVOUT types so maybe it is 
feasible for an audio driver to report events from an AV output.

I was wondering about how much sense does it make to you guys use a 
snd_soc_jack in this case?

Thanks in advance for your comments!

Ricardo
