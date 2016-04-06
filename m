From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v3] arm: omap2: remove redundant multiplatform checks
Date: Wed, 6 Apr 2016 14:15:19 +0530
Message-ID: <5704CC9F.6010502@ti.com>
References: <201604060526.ouhQYqrT%fengguang.wu@intel.com>
 <1459895738-6546-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
 <1459930448-32638-1-git-send-email-ve92mose@stud.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1459930448-32638-1-git-send-email-ve92mose@stud.informatik.uni-erlangen.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonas Rabenstein <ve92mose@stud.informatik.uni-erlangen.de>, Tony Lindgren <tony@atomide.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

+Tony

On Wednesday 06 April 2016 01:44 PM, Jonas Rabenstein wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> The directory arch/arm/mach-omap2 is only selected for compilation if
> CONFIG_ARCH_OMAP2PLUS is selected. CONFIG_ARCH_OMAP2PLUS itself is a
> silent option and all machines selecting this option are multiplatform
> devices. As a consequence checks for CONFIG_ARCH_MULTIPLATFORM as well
> as CONFIG_ARCH_OMAP2PLUS within that directory are superfluous and can
> be removed.

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
