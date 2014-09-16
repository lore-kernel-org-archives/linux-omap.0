From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 3/3] nand: omap2: Replace pr_err with dev_err
Date: Tue, 16 Sep 2014 11:48:13 +0300
Message-ID: <5417F94D.40902@ti.com>
References: <1410447730-16087-1-git-send-email-ezequiel@vanguardiasur.com.ar> <1410447730-16087-4-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50571 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770AbaIPIsz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 04:48:55 -0400
In-Reply-To: <1410447730-16087-4-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

On 09/11/2014 06:02 PM, Ezequiel Garcia wrote:
> Usage of pr_err is frowned upon, so replace it with dev_err.
> Aditionally, the message on nand_bch_init() error is redundant,
> since proper error is showed if the function fails.

You could have omitted the details about nand_bch_init() in the commit
message.

> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

