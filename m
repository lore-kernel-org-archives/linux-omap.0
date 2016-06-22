From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Get kexec working on SMP omap variants
Date: Wed, 22 Jun 2016 02:53:05 -0700
Message-ID: <20160622095303.GF22406@atomide.com>
References: <1466495565-17480-1-git-send-email-tony@atomide.com>
 <cfc75c15-ab10-22ee-35b8-529e28d2773c@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cfc75c15-ab10-22ee-35b8-529e28d2773c@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@oracle.com> [160621 09:10]:
> 
> I suggest to do bit wider testing including PM. From
> quick scan, the series looks fine to me.

Looks like the /sys/kernel/debug/pm_debug/count values for
both cores for off increse just fine with these patches
both before and after kexec.

> FWIW, Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Thanks,

Tony
