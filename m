From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 5/9] ARM/ASoC: omap-mcbsp: Remove
 CLKR/FSR mux configuration code
Date: Thu, 23 Aug 2012 11:12:46 +0300
Message-ID: <5035E5FE.90401@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-6-git-send-email-peter.ujfalusi@ti.com>
 <20120822191506.GL7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120822191506.GL7995@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On 08/22/2012 10:15 PM, Mark Brown wrote:
> Applied but this didn't quite apply cleanly, please check that it did so.

The part which removes the omap_mcbsp_6pin_src_mux() function from
sound/soc/omap/mcbsp.c is the one which did not made it.

It failed to apply on top of topic/omap is that the branch does not have the
following commit:
d0db84e ASoC: omap-mcbsp: Fix 6pin mux configuration

This patch is in your for-next branch. I can not find it in the for-3.6 or
for-3.7 branch either.

Commit d0db84e was planed to be part of 3.6 AFAIK. Without that patch in
topic/omap we are going to have merge issue with 3.7.

I can send a patch which removes the omap_mcbsp_6pin_src_mux() in topic/omap
but the patch will similarly fail when we going to have d0db84e already
applied mainline.

-- =

P=E9ter
