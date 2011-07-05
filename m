From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v6 08/18] mfd: twl6040: Add initial support
Date: Tue, 5 Jul 2011 12:28:17 +0300
Message-ID: <2205166.k2KJlqZUA7@barack>
References: <1308663556-29120-1-git-send-email-peter.ujfalusi@ti.com>
	<1650114.SY7VdjHPHs@barack> <20110704173935.GT3021@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110704173935.GT3021@sortiz-mobl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

On Monday 04 July 2011 19:39:35 Samuel Ortiz wrote:
> That is fine with me, yes. That's why I ACK the MFD patches for Tony to t=
ake
> them.

I have changed the series for Tony in my branch for the following comments:
wl6040_is_powered, twl6040_get_rev removal, since these are really small =

changes, if you want to see it before Tony pulls it, I can send the selecte=
d =

patches (few lines has been changed).

> Thanks in advance for the follow up patches.

For the twl6040_*_irq changes, I sent the series, since I ended up with a =

bigger change than I would have expected.

Regards, =

P=E9ter
