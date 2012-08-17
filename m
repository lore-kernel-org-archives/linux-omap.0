From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/9] ARM/ASoC: OMAP McBSP device tree
	support
Date: Fri, 17 Aug 2012 11:18:39 +0100
Message-ID: <20120817101838.GB30548@opensource.wolfsonmicro.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 16, 2012 at 04:40:59PM +0300, Peter Ujfalusi wrote:

> in order to be able to add DT support for the McBSP driver which is used on all
> OMAP platforms (OMAP1/2/3/4/5) I needed to make some cleanups to the stack:

Tony, are you OK with these changes going via ASoC?
