From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] OMAP3: PM: Bug fix in Smartreflex driver.
Date: Mon, 8 Mar 2010 20:05:06 +0200
Message-ID: <20100308180505.GA6630@gandalf>
References: <1268068851-30022-1-git-send-email-thara@ti.com>
 <1268068851-30022-2-git-send-email-thara@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35770 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab0CHSE5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 13:04:57 -0500
Content-Disposition: inline
In-Reply-To: <1268068851-30022-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

On Mon, Mar 08, 2010 at 10:50:49PM +0530, Thara Gopinath wrote:
> This patch sets and unsets is_sr_reset is appropriate places so that
> trying to enable smart reflex in a non-supported OMAP chip does not
> lead to unnecessary crash
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>

$SUBJECT is not really useful. You could describe the problem slightly
by saying something like:

fix crash when enabling SmartReflex on non-supported OMAPs

-- 
balbi
