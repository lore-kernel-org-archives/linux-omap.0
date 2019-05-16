From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] two fixes for omaps
Date: Wed, 15 May 2019 23:23:16 -0700
Message-ID: <20190516062316.3amk72lykcmugnyu@localhost>
References: <pull-1556727306-300309@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1556727306-300309@atomide.com>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 01, 2019 at 09:15:36AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 81717283cf2c4c4d9bf8fd618cd6e5bdfe082edd:
> 
>   Merge commit '7d56bedb2730dc2ea8abf0fd7240ee99ecfee3c9' into omap-for-v5.1/fixes (2019-04-01 09:36:25 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/fixes-rc6
> 
> for you to fetch changes up to 6a38df676a0a06bfc7ff8607ac62ccd6d95969ad:
> 
>   ARM: dts: logicpd-som-lv: Fix MMC1 card detect (2019-04-30 08:49:25 -0700)
> 
> ----------------------------------------------------------------
> Two regression fixes for omaps
> 
> Two one-liners to fix board-ams-delta booting regression and
> logicpd-som-lv MMC card detect to use GPIO_ACTIVE_LOW instead of
> IRQ_TYPE_LEVEL_LOW. Note that the board-ams-delta regression has
> been in there already since v5.0, so if necessary these can wait
> for the merge window.

Merged into arm/late for 5.2. Thanks!


-Olof
