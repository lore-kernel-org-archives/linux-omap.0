From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv6 10/10] ARM: OMAP2+: pdata-quirks: add PRM data for
 reset support
Date: Fri, 20 Sep 2019 07:26:47 -0700
Message-ID: <20190920142647.GR5610@atomide.com>
References: <20190912170953.GT52127@atomide.com>
 <20190919123258.23172-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190919123258.23172-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, p.zabel@pengutronix.de, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [190919 12:33]:
> The parent clockdomain for reset must be in force wakeup mode, otherwise
> the reset may never complete. Add pdata quirks for this purpose for PRM
> driver.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> v6: replaced platform specific compatibles with a single common
>     compatible check

Thanks looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
