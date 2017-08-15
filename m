From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 01/11] ASoC: codecs: make snd_soc_platform_driver const
Date: Tue, 15 Aug 2017 09:11:43 +0100
Message-ID: <20170815081143.cpkronjaqjo5ike5@localhost.localdomain>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-2-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1502710730-18912-2-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, Xiubo.Lee@gmail.com, yang.jie@linux.intel.com, timur@tabi.org, lgirdwood@gmail.com, krzk@kernel.org, s.nawrocki@samsung.com, bardliao@realtek.com, robert.jarzmik@free.fr, linux-omap@vger.kernel.org, plai@codeaurora.org, Paul.Handrigan@cirrus.com, chiou@realtek.com, haojian.zhuang@gmail.com, nicoleotsuka@gmail.com, julia.lawall@lip6.fr, broonie@kernel.org, perex@perex.cz, linux-arm-kernel@lists.infradead.org, brian.austin@cirrus.com, sbkim73@samsung.com, patches@opensource.cirrus.com, tiwai@suse.com, linux-kernel@vger.kernel.org, jarkko.nikula@bitmer.com, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org, daniel@zonque.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 14, 2017 at 05:08:40PM +0530, Bhumika Goyal wrote:
> Make these const as they are either passed as the 2nd argument to the
> function devm_snd_soc_register_platform or snd_soc_register_platform,
> and the arguments are of type const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---

For the Wolfson bits:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
