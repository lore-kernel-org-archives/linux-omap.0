From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH] net: cpsw: Fix ethernet regression for dm814x
Date: Thu, 19 Nov 2015 12:42:34 +0530
Message-ID: <564D7662.9020101@ti.com>
References: <1447896445-6120-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1447896445-6120-1-git-send-email-tony@atomide.com>
Sender: netdev-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 19 November 2015 06:57 AM, Tony Lindgren wrote:
> Commit b6745f6e4e63 ("drivers: net: cpsw: davinci_emac: move reading mac
> id to common file") started using of_machine_is_compatible for detecting
> type but missed at dm8148 causing Ethernet to stop working.
> 
> Let's fix the issue by adding handling for dm814x.
> 
> Cc: Mugunthan V N <mugunthanvnm@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Mugunthnan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
