From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Sun, 1 Apr 2018 16:17:46 -0700
Message-ID: <20180401231746.GC5700@atomide.com>
References: <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com> <20180329160828.GA14007@amd>
 <20180329163450.GQ5700@atomide.com> <20180329180541.GA26545@amd>
 <20180329215840.GT5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180329215840.GT5700@atomide.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180329 22:00]:
> If it entered low-power mode, in theory we should see the state
> change interrupt that's handled by phy-mapphone-mdm6600.c.
> I never managed to do that so far so maybe you figured it out
> with some command.

And looks like the trigger to mdm6600 to enter low power states
is done via USB:

# echo auto > /sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb1/1-1/power/level

Looks like with that and modem enabled I'm seeing 207mW power
consumption on a and idle system with screen off on my power supply.
Opening /dev/ttyUSB4 makes the power consumption go up to 502mW..
So now we need the wakeirqs and PM runtime to work for ohci and
then the device can be used for few hours on batteries.

Regards,

Tony
