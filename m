From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: use BUG_ON where possible
Date: Mon, 12 Nov 2012 15:21:21 -0800
Message-ID: <20121112232120.GX6801@atomide.com>
References: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
 <1352406191-14303-7-git-send-email-sasha.levin@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352406191-14303-7-git-send-email-sasha.levin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sasha.levin@oracle.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sasha Levin <sasha.levin@oracle.com> [121108 12:26]:
> Just use BUG_ON() instead of constructions such as:
> 
> 	if (...)
> 		BUG()
> 
> A simplified version of the semantic patch that makes this transformation
> is as follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e;
> @@
> - if (e) BUG();
> + BUG_ON(e);
> // </smpl>
> 
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>

Thanks applying into omap-for-v3.8/board-v2.

Regards,

Tony
