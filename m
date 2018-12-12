From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap1 changes for v4.21
Date: Wed, 12 Dec 2018 13:59:17 -0800
Message-ID: <20181212215917.yao2orsyr6qqagi2@localhost>
References: <pull-1544638322-89579@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1544638322-89579@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 12, 2018 at 10:13:14AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/omap1-signed
> 
> for you to fetch changes up to 5a87809b89b64c0ccd82261de53c41f2fffb56da:
> 
>   Merge branch 'omap1-usb-fix' into omap-for-v4.21/omap1 (2018-12-11 08:14:58 -0800)
> 
> ----------------------------------------------------------------
> Changes for omap1 variants for v4.21 merge window
> 
> In this set of changes Aaro Koskinen revives Palm Tungsten E for the
> MMC and USB making it usable again. And Janusz Krzysztofik follows up
> on the clean-up of  ams-delta GPIO handling. The other changes are
> clean-up for DEFINE_SHOW_ATTRIBUTE by Yangtao Li.

Cool, merged into next/soc now. Is the kernel about to outgrow these platforms
due to binary size just slowly increasing over time, or is it still usable?


-Olof
