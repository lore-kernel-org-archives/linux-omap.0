From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv4 0/2] McBSP: OMAP3: Add sidetone feature
Date: Fri, 19 Feb 2010 15:39:16 +0200
Message-ID: <20100219153916.a3dc4a77.jhnikula@gmail.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
	<20100218222229.0f0eb3a9.jhnikula@gmail.com>
	<201002191034.32391.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <201002191034.32391.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 19 Feb 2010 10:34:32 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> I'm not sure, but you might need to configure the taps as well to have the 
> correct sidetone.
> Also I have a recollection, that the McBSP sidetone requires DSP mode (TDM) in 
> order to operate correctly, so on Beagle you might need to set up 4 channel 
> mode. And how the channel mapping in 4 channel mode works in McBSP sidetone is 
> another matter...
> 
It seems to work with I2S too.

I think I forgot to enable control 'McBSP2 Sidetone' when I last time
tried this set (v1 or v2). But now my null test below works and I can
hear that the level is changing when I adjust the volumes with amixer.

echo 32767 >/sys/devices/platform/omap-mcbsp.2/st_taps

arecord -f dat >/dev/null |aplay -f dat /dev/zero

amixer set -D hw:0 'McBSP2 Sidetone Channel 0' 32700
amixer set -D hw:0 'McBSP2 Sidetone Channel 0' 327
amixer set -D hw:0 'McBSP2 Sidetone Channel 0' -- -32700


-- 
Jarkko
