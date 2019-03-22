From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/12] ARM: OMAP2+: add missing of_node_put after
 of_device_is_available
Date: Fri, 22 Mar 2019 15:24:54 -0700
Message-ID: <20190322222454.GJ19425@atomide.com>
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
 <1550928043-14889-12-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1550928043-14889-12-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Julia Lawall <Julia.Lawall@lip6.fr> [190223 13:58]:
> Add an of_node_put when a tested device node is not available.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> identifier f;
> local idexpression e;
> expression x;
> @@
> 
> e = f(...);
> ... when != of_node_put(e)
>     when != x = e
>     when != e = x
>     when any
> if (<+...of_device_is_available(e)...+>) {
>   ... when != of_node_put(e)
> (
>   return e;
> |
> + of_node_put(e);
>   return ...;
> )
> }
> // </smpl>
> 
> Fixes: e0c827aca0730 ("drm/omap: Populate DSS children in omapdss driver")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thanks applying this one into omap-for-v5.1/fixes.

Regards,

Tony
