From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v6 01/10] ARM: OMAP2+: nand: unify init functions
Date: Tue, 21 Aug 2012 14:37:00 +0300
Message-ID: <503372DC.20504@compulab.co.il>
References: <cover.1345524670.git.afzal@ti.com> <8e0958354be60d026e7e03bd179509fcbe70957b.1345524670.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:34463 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678Ab2HULhJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 07:37:09 -0400
In-Reply-To: <8e0958354be60d026e7e03bd179509fcbe70957b.1345524670.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, jon-hunter@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

Thanks for the patches!

On 08/21/12 13:45, Afzal Mohammed wrote:
> Helper function for updating nand platform data has been
> added the capability to take timing structure arguement.
> Usage of omap_nand_flash_init() has been replaced by modifed
> one, omap_nand_flash_init was doing things similar to
> board_nand_init except that NAND CS# were being acquired
> based on bootloader setting. As CS# is hardwired for a given
> board, acquiring gpmc CS# has been removed, and updated with
> the value on board.
> 
> NAND CS# used in beagle board & omap3evm was found to be CS0.
> Thomas Weber <thomas.weber.linux@googlemail.com> reported
> that value of devkit8000 to be CS0. Overo board was found
> to be using CS0 based on u-boot, while google grep says
> omap3touchbook too has CS0.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
