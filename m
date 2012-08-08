From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/11] MFD: twl4030-audio: Add DT support
Date: Wed, 8 Aug 2012 15:18:50 +0100
Message-ID: <20120808141849.GA24328@opensource.wolfsonmicro.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <20120808131356.GS16861@opensource.wolfsonmicro.com>
 <50226CF4.1010202@ti.com>
 <20120808135253.GC16861@opensource.wolfsonmicro.com>
 <502274DA.9020204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <502274DA.9020204@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 08, 2012 at 05:16:58PM +0300, Peter Ujfalusi wrote:
> On 08/08/2012 04:52 PM, Mark Brown wrote:

> > Is the point it's at in the sequence the end?

> On both ends :o
> On HS enable: the extmute has to be enabled, run the power on sequence for the
> HS, wait for ramp, disable the HS extmute.

> On stop: enable the extmute, run the sequence, wait for ramp, release the extmute.

I'm struggling to see any reason not to just hold the external mute on
for the entire time the headset is powered off?

> > We can always add a patch stubbing it out as part of the series, or in a
> > branch in the OF tree that we can pull in.

> If you are OK with the hassle I can add a patch to the series for
> include/linux/of.h to handle this.

Yes, please.
