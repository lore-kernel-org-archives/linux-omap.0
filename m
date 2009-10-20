From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/4] ASoC: TWL4030: Driver registration via
	twl4030_codec MFD
Date: Tue, 20 Oct 2009 15:01:28 +0300
Message-ID: <200910201501.28160.peter.ujfalusi@nokia.com>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
	<200910201430.49223.peter.ujfalusi@nokia.com>
	<20091020115106.GB2909@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091020115106.GB2909@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 October 2009 14:51:06 ext Mark Brown wrote:
> Sure, though I suspect patch 3 could just be split in two happily with
> an include.  I don't really mind either way.  If you are going to keep
> them as one patch it'd be good to call out the move in the changelog.

I'll split the soc codec patch to two, one is changing the header the other=
 is =

for the change in the codec driver.

> That's a good enough reason to leave things as they are, though really
> if you're building SND_SOC_ALL_CODECs in a production system you're
> being a bit strange.

Fair enough.

> >
> >  +MODULE_ALIAS("platform:twl4030_codec_audio");
> =

> Yes.  The aliasing makes no reference to the parents of the device, it
> only cares about the device name - for the purposes of module loading
> and driver matching it's identical to any other platform device.

Good to know, I'll change this as well.

Thanks,
P=E9ter
