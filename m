From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_3/5=5D_MFD=3A_twl4030-codec?=
 =?iso-8859-1?q?=3A_APLL=5FINFREQ_handling_in_the=09MFD_driver?=
Date: Tue, 3 Nov 2009 16:02:16 +0200
Message-ID: <200911031602.16074.peter.ujfalusi@nokia.com>
References: <1257165295-9352-1-git-send-email-peter.ujfalusi@nokia.com>
	<200911031537.50430.peter.ujfalusi@nokia.com>
	<20091103134437.GA22501@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091103134437.GA22501@sirena.org.uk>
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
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 03 November 2009 15:44:38 ext Mark Brown wrote:
> > on board. Another reason is that we have other part of the twl, which
> > needs resources from the codec part, but it is not loaded through the
> > codec MFD, so providing the needed information is kind of tricky with
> > that setup.
> =

> I had thought that the sub-device was supposed to handle the arbitration
> and could be used here.

That would have been ideal. As such the audio and the Vibra interface is th=
e =

only one directly inside of the codec part of twl, but there is a need for =
other =

modules to actually control resources within the codec part in order to ope=
rate, =

but they are not actually sub-devices of the codec MFD.

-- =

P=E9ter
