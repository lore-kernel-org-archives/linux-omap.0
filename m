From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] clean-up for omap1 for v4.13
Date: Sun, 18 Jun 2017 20:32:58 -0700
Message-ID: <20170619033258.GM30022@localhost>
References: <594110d3.05159d0a.1eb5a.5f93SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <594110d3.05159d0a.1eb5a.5f93SMTPIN_ADDED_BROKEN@mx.google.com>
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

On Wed, Jun 14, 2017 at 03:32:44AM -0700, Tony Lindgren wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/omap1-signed
> 
> for you to fetch changes up to 764e4ef0a8871339eeddaf27ccc47aeeea28b974:
> 
>   ARM: OMAP1: Fix a typo in a comment line (2017-06-06 23:54:13 -0700)
> 
> ----------------------------------------------------------------
> A series of omap1 changes for issues found by Coccinelle.
> 
> ----------------------------------------------------------------
> Markus Elfring (5):
>       ARM: OMAP1: DMA: Improve a size determination in omap1_system_dma_init()
>       ARM: OMAP1: DMA: Delete an error message for a failed memory allocation in omap1_system_dma_init()
>       ARM: OMAP1: DMA: Delete an unnecessary return statement in omap1_show_dma_caps()
>       ARM: OMAP1: Delete an error message for a failed memory allocation in omap1_dm_timer_init()
>       ARM: OMAP1: Fix a typo in a comment line

Thanks, merged into next/soc.


-Olof
