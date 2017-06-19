From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/2] omap gpmc changes for v4.13
Date: Sun, 18 Jun 2017 18:56:21 -0700
Message-ID: <20170619015621.GC30022@localhost>
References: <5937f0c8.4debca0a.53849.e49dSMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5937f0c8.4debca0a.53849.e49dSMTPIN_ADDED_BROKEN@mx.google.com>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 07, 2017 at 05:25:24AM -0700, Tony Lindgren wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/gpmc-signed
> 
> for you to fetch changes up to c9eabf40d91b4fe954efe380d88590d933baa06d:
> 
>   memory: omap-gpmc: add error message if bank-width property is absent (2017-05-31 10:08:10 -0700)
> 
> ----------------------------------------------------------------
> Few improvments for GPMC (General Purpose Memory Controller)
> found on TI SoCs to produce an error for missing bank-width
> and to make the bootloader timing debug output usable for
> device tree timings.

Thanks, merged into next/drivers.


-Olof
