From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/4] twl4030 codec as MFD device
Date: Wed, 21 Oct 2009 11:56:33 +0300
Message-ID: <200910211156.33505.peter.ujfalusi@nokia.com>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "sameo@linux.intel.com" <sameo@linux.intel.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Hello Samuel,

On Monday 19 October 2009 15:42:16 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> Hello,
> =

> The following series adds new MFD device on top of the twl4030 MFD device
>  for the codec part of the chip, and also converts the soc audio driver to
>  use the correct probing (device model).
> =

> Reason for the twl4030_codec MFD: the vibra control is actually in the
>  codec part of the twl4030. If both the vibra and the audio functionality
>  is needed from the twl4030 at the same time, than they need to control t=
he
>  codec power and APLL at the same time without breaking the other driver.
> Also these two has to be able to work without the need for the other
>  driver.

Have you had time to look at the series?
I have made all the modification suggested by Mark Brown, and I'm holding b=
ack =

the second series (to have the comments from you for the initial series), s=
o I =

can address those in the same round.

Thank you,
P=E9ter
