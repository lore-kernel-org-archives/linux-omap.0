From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 05/11] ASoC: omap: make snd_soc_platform_driver const
Date: Tue, 15 Aug 2017 09:05:55 +0300
Message-ID: <20170815060555.GA3824@bitmer.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-6-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1502710730-18912-6-git-send-email-bhumirks@gmail.com>
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
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, Xiubo.Lee@gmail.com, yang.jie@linux.intel.com, timur@tabi.org, lgirdwood@gmail.com, krzk@kernel.org, s.nawrocki@samsung.com, bardliao@realtek.com, robert.jarzmik@free.fr, linux-omap@vger.kernel.org, plai@codeaurora.org, Paul.Handrigan@cirrus.com, chiou@realtek.com, haojian.zhuang@gmail.com, nicoleotsuka@gmail.com, julia.lawall@lip6.fr, broonie@kernel.org, perex@perex.cz, linux-arm-kernel@lists.infradead.org, brian.austin@cirrus.com, sbkim73@samsung.com, patches@opensource.cirrus.com, tiwai@suse.com, linux-kernel@vger.kernel.org, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org, daniel@zonque.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 14, 2017 at 05:08:44PM +0530, Bhumika Goyal wrote:
> Make this const as it is only passed as the 2nd argument to the
> function devm_snd_soc_register_platform, which is of type const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  sound/soc/omap/omap-pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
