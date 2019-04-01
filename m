From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 06/12] omapfb: add missing of_node_put after
 of_device_is_available
Date: Mon, 1 Apr 2019 14:07:17 +0200
Message-ID: <f06e8d3a-a98d-239b-d5e1-e5fad2bc4bb9@samsung.com>
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
        <CGME20190223135900epcas2p27cce442a6e691905bd290e89d4c17dbb@epcas2p2.samsung.com>
        <1550928043-14889-7-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550928043-14889-7-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 02/23/2019 02:20 PM, Julia Lawall wrote:
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
> Fixes: f76ee892a99e6 ("omapfb: copy omapdss & displays for omapfb")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
