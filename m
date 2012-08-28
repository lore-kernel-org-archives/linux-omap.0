From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 02/14] MFD: twl4030-audio: Convert to
	use devm_kzalloc
Date: Tue, 28 Aug 2012 09:48:26 -0700
Message-ID: <20120828164825.GA4534@opensource.wolfsonmicro.com>
References: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>
 <1344954162-7985-3-git-send-email-peter.ujfalusi@ti.com>
 <1346147410.2182.96.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1346147410.2182.96.camel@sokoban>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 28, 2012 at 12:50:10PM +0300, Tero Kristo wrote:
> On Tue, 2012-08-14 at 17:22 +0300, Peter Ujfalusi wrote:
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> I think this one could use a short commit message, also about why
> kfree():s are dropped (handled internally by devm_* etc.)

Honestly I think people should be able to figure this out, it's not like
it's an obscure API nobody ever used before.
