From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/5 v1] ASoC Add TLV320AIC23 codec driver
Date: Tue, 30 Sep 2008 12:02:56 +0100
Message-ID: <20080930110255.GE19862@sirena.org.uk>
References: <dfeb90390809300259k1b848aaehc3519ec50c6ec96d@mail.gmail.com>
	<20080930101951.GA19862@sirena.org.uk>
	<dfeb90390809300347o4b386cffrb78c282f41e68fe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <dfeb90390809300347o4b386cffrb78c282f41e68fe9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 30, 2008 at 04:17:38PM +0530, Arun KS wrote:
> On Tue, Sep 30, 2008 at 3:49 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> > There are no routes here for your bypass path(s) - this will mean that
> > DAPM won't power them on unless there's an active playback and record.
> > At present that's fine for digital only bypass paths but if there are
> > analogue ones they should be visible here.

> I made the bypass and sidetone as controls. The user can switchon them
> through amixer controls.

Right, they should be visible DAPM controls to allow user control.

>  sh-3.00# amixer cset numid=9 1
> numid=9,iface=MIXER,name='Line Bypass'
>   ; type=BOOLEAN,access=rw------,values=1
>   : values=on
> sh-3.00# amixer cset numid=11 1
> numid=11,iface=MIXER,name='PGA Mixer Line Switch'
>   ; type=BOOLEAN,access=rw------,values=1
>   : values=on

> Its working.

Hrm.  That suggests that there's a bug in the power management
somewhere - without routes DAPM won't know to power up any of the output
stages when the bypass paths are in use, leaving them unpowered.  

Note that a lot of PGAs will pass through audio when powered down so you
need to check that things like mute and gain controls are functioning as
expected rather than just testing for the presence of a signal.  Then
again, looking at your driver again I don't see any power managent for
the output stages either...

You can see what DAPM is powering up by looking at:

	/sys/bus/platform/devices/soc-audio/dapm_widgets

Even if this works within the device DAPM still needs to know about the
bypass paths so that it can manage components outside the codec.
