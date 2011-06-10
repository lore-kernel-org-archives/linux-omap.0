From: =?iso-8859-15?q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 06/12] MFD: twl4030-codec ->
	twl4030-audio: Rename the driver
Date: Fri, 10 Jun 2011 07:52:51 +0300
Message-ID: <201106100752.51718.peter.ujfalusi@ti.com>
References: <1307626230-29660-1-git-send-email-peter.ujfalusi@ti.com>
	<1307626230-29660-7-git-send-email-peter.ujfalusi@ti.com>
	<201106092137.28678.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <201106092137.28678.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark@alsa-project.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Lopez Cruz,   Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 09 June 2011 22:37:28 Arnd Bergmann wrote:
> Better use the -M flag to git-format-patch when moving files, to make it
> obvious what has or has not changed, and to reduce the size of the email.

I tend to forgot the -M flag, thanks.
 =

> Also, shouldn't this file go into the sound/soc/ directory? It seems that
> this is really the device driver, not part of the multi-function layer.

This driver is the MFD core part for the audio block within the twl4030 ser=
ies =

pmic.
We have the slave drivers under sound/soc/codecs/twl4030.c and =

drivers/input/misc/twl4030-vibra.c.
The audio block has codec, and vibra functionality, and we need to have thi=
s =

driver to properly manage this block within twl.

-- =

P=E9ter
