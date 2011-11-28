From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/5] ASoC: OMAP4: omap-dmic: Initial
 support for OMAP DMIC
Date: Mon, 28 Nov 2011 11:44:05 +0000
Message-ID: <20111128114404.GE2934@opensource.wolfsonmicro.com>
References: <1322223636-31623-1-git-send-email-peter.ujfalusi@ti.com>
	<1322223636-31623-3-git-send-email-peter.ujfalusi@ti.com>
	<20111127195040.GC25598@opensource.wolfsonmicro.com>
	<2729071.3pgFW4tmaY@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <2729071.3pgFW4tmaY@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 28, 2011 at 09:49:19AM +0200, P=E9ter Ujfalusi wrote:
> On Sunday 27 November 2011 19:50:41 Mark Brown wrote:

> > So what happens if the user starts recording at 192kHz then goes back to
> > 96kHz?  This all feels a bit clunky and fragile.

> I expect another HW param calls. The stream is stopped, and I reconfigure=
 the =

> divider for 96KHz (I will not change the divider here, since the stream i=
s =

> 96KHz). I don't see any issue here.

Only if the user is using the same machine driver as you.  If the user
wants a fixed clock rate for the DMIC and sets it on init rather than
resetting it every time hw_params() is called then this will break.
