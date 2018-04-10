From: Tony Lindgren <tony@atomide.com>
Subject: Re: simultaneous voice/data works (was Re: call/normal
 switch was Re: omap4-droid4: voice call support was)
Date: Tue, 10 Apr 2018 06:50:29 -0700
Message-ID: <20180410135029.GS5700@atomide.com>
References: <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
 <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
 <20180407081000.GB7818@amd> <20180407122233.GA11302@amd>
 <cbfc3cfa8acbc02dde848ec4e1d71b5089ff1d10.camel@redhat.com>
 <20180409140847.GP5700@atomide.com> <20180410105840.GA13697@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180410105840.GA13697@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180410 11:00]:
> On Mon 2018-04-09 07:08:47, Tony Lindgren wrote:
> > * Dan Williams <dcbw@redhat.com> [180408 02:46]:
> > > On Sat, 2018-04-07 at 14:22 +0200, Pavel Machek wrote:
> > > > I tried --location-enable-gps-unmanaged , but that did not work for
> > > > me.
> > > 
> > > That requires a TTY that would spit out the GPS data; in this mode MM
> > > only sends the start/stop commands, and what comes out the GPS TTY is
> > > undefined (at least by MM).
> > > 
> > > So unless you know that one of the 6600's TTYs does GPS and in what
> > > format it does GPS, then no.
> > 
> > There should be a NMEA port within the unknown port range ttyUSB[123].
> > 
> > Is there some easy way to enable --location-enable-gps-unmanaged for
> > testing so I can check if GPS gets enabled for one of the ports?
> 
> This should be userful for testing:
> 
> Just pass --pds-start-gps and you should get NMEA on stdout.

Hmm maybe also try to check if enabling the GPS this way starts
printing something out of /dev/ttyUSB[123]?

Regards,

Tony
