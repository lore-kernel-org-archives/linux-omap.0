From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/5] ASoC: OMAP: mcbsp fixes for enabling ARM multiplatform
 support
Date: Thu, 22 Nov 2012 15:02:00 +0100
Message-ID: <50AE3058.1080204@ti.com>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
 <20121121174225.25576.54891.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121121174225.25576.54891.stgit@muffinssi.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11/21/2012 06:42 PM, Tony Lindgren wrote:
> We cannot include any plat or mach headers for the multiplatform
> support.
> 
> Fix the issue by defining local mcbsp_omap1().
> 
> cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> cc: Liam Girdwood <lrg@ti.com>
> cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> cc: Jaroslav Kysela <perex@perex.cz>
> cc: Takashi Iwai <tiwai@suse.de>
> cc: alsa-devel@alsa-project.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
