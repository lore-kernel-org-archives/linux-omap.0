From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: [PATCH] Alsa modularisations and support for tsc2101 6/7
Date: Tue, 21 Feb 2006 07:39:59 -0600
Message-ID: <520AB2AD990DC04082102F77CA1726381036ED@dlee03.ent.ti.com>
References: <43FA0A3B.7070303@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lamikr@cc.jyu.fi, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

+#define CODEC_CLOCK 12000000

+#define AUDIO_MCBSP OMAP_MCBSP1

we should be quering the sysclk for figuring out the codec_clk. some =
boards such as sdp2430 have an interesting property of being able to =
provide 12/13mhz clk to the codec.. and hardcoding mcbsp1 wil have =
portability issues on omap2420 does this belong to platform structure?

Regards,

Nishanth Menon


________________________________

From: linux-omap-open-source-bounces+x0nishan=3Dti.com@linux.omap.com on =
behalf of lamikr
Sent: Mon 2/20/2006 12:28 PM
To: OMAP-Linux
Subject: [PATCH] Alsa modularisations and support for tsc2101 6/7



ALSA Omap Patch

This patch creates support for tsc2101 codec for alsa omap. Tested with
boards H2 and iPAQ h6300.

signed-off by Mika Laitio <lamikr@cc.jyu.fi>
signed-off by Daniel Petrini <d.pensator@gmail.com>

----------------
Mika Laitio
