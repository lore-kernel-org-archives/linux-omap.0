From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] fixes for omaps for v5.1-rc cycle
Date: Sun, 7 Apr 2019 15:17:02 -0700
Message-ID: <20190407221702.gavxlc63soeeterv@localhost>
References: <pull-1554414783-873154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1554414783-873154@atomide.com>
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

On Thu, Apr 04, 2019 at 02:53:36PM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/fixes-signed
> 
> for you to fetch changes up to 81717283cf2c4c4d9bf8fd618cd6e5bdfe082edd:
> 
>   Merge commit '7d56bedb2730dc2ea8abf0fd7240ee99ecfee3c9' into omap-for-v5.1/fixes (2019-04-01 09:36:25 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps for v5.1-rc cycle
> 
> Few small fixes for omap variants:
> 
> - Fix ams-delta gpio IDs
> 
> - Add missing of_node_put for omapdss platform init code
> 
> - Fix unconfigured audio regulators for two am335x boards
> 
> - Fix use of wrong offset for am335x d_can clocks

Merged, thanks!


-Olof
