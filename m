From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: print error if wait_target_ready()
 failed
Date: Mon, 29 Dec 2014 11:38:58 +0200
Message-ID: <54A12132.9010100@ti.com>
References: <1418992490-2901-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49579 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbaL2Jj0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Dec 2014 04:39:26 -0500
In-Reply-To: <1418992490-2901-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>, paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, t-kristo@ti.com, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org

On 19/12/14 14:34, Lokesh Vutla wrote:
> Fixed pr_debug to pr_err when hwmod returns an error when enabling
> a module.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

