From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] few omap driver fixes for v4.21
Date: Wed, 12 Dec 2018 14:21:04 -0800
Message-ID: <20181212222104.yww344h66ql5lg4s@localhost>
References: <pull-1544638438-182658@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1544638438-182658@atomide.com>
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

On Wed, Dec 12, 2018 at 10:14:33AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 3be5e10daf1fc063ec5cff3cd785c4a59814af0b:
> 
>   Merge branch 'omap-for-v4.21/ti-sysc' into omap-for-v4.21/driver (2018-11-29 11:39:23 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/driver-part2-signed
> 
> for you to fetch changes up to c2ade654dbf7d02f09ad491f5621fc321d4af96b:
> 
>   memory: omap-gpmc: Use of_node_name_eq for node name comparisons (2018-12-11 08:30:29 -0800)
> 
> ----------------------------------------------------------------
> Few more omap driver fixes and improvments for v4.21 merge window
> 
> This series of changes improves the TI module flag handling to allow
> booting with older dts files until the module flags have been moved
> to the interconnect target module level. And there's a of_node_name_eq()
> clean-up patch from Rob Herring for the GPMC driver.

Merged into next/drivers. Thanks.


-Olof
