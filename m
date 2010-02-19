From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCHv4 0/2] McBSP: OMAP3: Add sidetone feature
Date: Fri, 19 Feb 2010 15:37:17 +0200
Message-ID: <1266586637.2044.2.camel@eenurkka-desktop>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
	<20100218222229.0f0eb3a9.jhnikula@gmail.com>
	<201002191034.32391.peter.ujfalusi@nokia.com>
	<20100219153916.a3dc4a77.jhnikula@gmail.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100219153916.a3dc4a77.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 2010-02-19 at 14:39 +0100, ext Jarkko Nikula wrote:
> On Fri, 19 Feb 2010 10:34:32 +0200
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> 
> > I'm not sure, but you might need to configure the taps as well to have the 
> > correct sidetone.
> > Also I have a recollection, that the McBSP sidetone requires DSP mode (TDM) in 
> > order to operate correctly, so on Beagle you might need to set up 4 channel 
> > mode. And how the channel mapping in 4 channel mode works in McBSP sidetone is 
> > another matter...
> > 
> It seems to work with I2S too.
> 

For both channels? I don't recall so.. and for the one channel only, the
FIR doesn't behave expectedly? (maybe this works [1,0,..0], but more
sophisticated ones may not..)

> I think I forgot to enable control 'McBSP2 Sidetone' when I last time
> tried this set (v1 or v2). But now my null test below works and I can
> hear that the level is changing when I adjust the volumes with amixer.
> 
> echo 32767 >/sys/devices/platform/omap-mcbsp.2/st_taps
> 
> arecord -f dat >/dev/null |aplay -f dat /dev/zero
> 
> amixer set -D hw:0 'McBSP2 Sidetone Channel 0' 32700
> amixer set -D hw:0 'McBSP2 Sidetone Channel 0' 327
> amixer set -D hw:0 'McBSP2 Sidetone Channel 0' -- -32700
> 
> 
