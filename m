From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 0/4] Get kexec working on SMP omap variants
Date: Tue, 21 Jun 2016 09:07:59 -0700
Message-ID: <cfc75c15-ab10-22ee-35b8-529e28d2773c@oracle.com>
References: <1466495565-17480-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466495565-17480-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 6/21/2016 12:52 AM, Tony Lindgren wrote:
> Hi all,
>
> Here are some patches to make kexec work for SMP omaps. To test
> these you need to use the latest kexec-tools.git kexec with
> Russell's recent patches in "[PATCH 0/2] Simple fix to the ARM
> kexec tools implementation" thread fixed for 6x. Or else you
> need to use appended DTB.
>
> I've tested these so far on 4430 duovero, omap5-uevm, and
> beagle-x15.
>

>
>
> Tony Lindgren (4):
>   ARM: OMAP4+: Initialize SAR RAM base early for proper CPU1 reset for
>     kexec
>   ARM: OMAP4+: Prevent CPU1 related hang with kexec
>   ARM: OMAP4+: Reset CPU1 properly for kexec
>   ARM: OMAP4+: Allow kexec on SMP variants
>

I suggest to do bit wider testing including PM. From
quick scan, the series looks fine to me.

FWIW, Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
