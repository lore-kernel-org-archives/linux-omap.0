From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 2/3] nand: omap2: Remove horrible ifdefs to fix module
 probe
Date: Tue, 16 Sep 2014 11:43:59 +0300
Message-ID: <5417F84F.1010602@ti.com>
References: <1410447730-16087-1-git-send-email-ezequiel@vanguardiasur.com.ar> <1410447730-16087-3-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50357 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513AbaIPIoZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 04:44:25 -0400
In-Reply-To: <1410447730-16087-3-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

On 09/11/2014 06:02 PM, Ezequiel Garcia wrote:
> The current code abuses ifdefs to determine if the selected ECC scheme
> is supported by the running kernel. As a result the code is hard to read,
> and it also fails to load as a module.
> 
> This commit removes all the ifdefs and instead introduces a function
> omap2_nand_ecc_check() to check if the ECC is supported by using
> IS_ENABLED(CONFIG_xxx).
> 
> Since IS_ENABLED() is true when a config is =y or =m, this change fixes the
> module so it can be loaded with no issues.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

