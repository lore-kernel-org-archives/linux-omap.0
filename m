From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 0/2] ARM: AM43xx: PRM: fix reset handling issues
Date: Tue, 5 May 2015 11:32:26 -0500
Message-ID: <5548F09A.10401@ti.com>
References: <1430832785-1976-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1430832785-1976-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, s-anna@ti.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tero,
On 05/05/2015 08:33 AM, Tero Kristo wrote:
> Hi,
> 
> The work done for consolidating PRM code introduced a reset issue
> on AM43xx which is visible at least with wkup-m3, and prevents
> taking the wkup-m3 core out from reset. Fixed by passing all the
> relevant PRCM data from hwmod data, which was previously partly
> omitted on OMAP4+ case.
> 
> This set also removes some redundant AM33xx hwmod code and just
> re-uses the OMAP4+ version of the same.
> 
> Thanks to Dave Gerlach and Anna Suman for reporting this. Dave, care
> to give this patch set a try to see if it fixes the problem you see?
> 

Thanks for fixing this up, I swapped these patches for my reset patch on my
suspend branch [1] and tested the following:

am335x-gp-evm: boot and firmware loaded, suspend/resume multiple cycles
am437x-gp-evm: boot and firmware loaded, suspend/resume multiple cycles

Patches look fine to me.

Regards,
Dave

[1] https://github.com/dgerlach/linux-pm/tree/pm-ds0-v4.1-rc1-WIP

> Testing done:
> - am335x-bone: boot
> - am437x-gp-evm: boot
> - omap4-panda-es: boot, suspend/resume, cpuidle
> 
> -Tero
> 
