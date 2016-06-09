From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Select OMAP_INTERCONNECT for SOC_AM43XX
Date: Thu, 9 Jun 2016 00:22:45 -0700
Message-ID: <20160609072245.GM22406@atomide.com>
References: <4af329be31b140a7cd71351cf8f2d2006194e42b.1464105749.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4af329be31b140a7cd71351cf8f2d2006194e42b.1464105749.git.d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [160524 09:14]:
> AM43XX SoCs make use of the omap_l3_noc driver so explicitly select
> OMAP_INTERCONNECT in the Kconfig for SOC_AM43XX to ensure it always gets
> enabled for AM43XX only builds.

Applying into omap-for-v4.7/fixes thanks.

Tony
