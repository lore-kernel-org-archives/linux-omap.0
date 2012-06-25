From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v4 1/3] ARM: OMAP2+: nand: unify init functions
Date: Mon, 25 Jun 2012 10:29:57 -0500
Message-ID: <4FE883F5.6040806@ti.com>
References: <cover.1340354985.git.afzal@ti.com> <cdcf19df902fbfa0632371f94309f21544cdad21.1340354986.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35403 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab2FYPaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 11:30:03 -0400
In-Reply-To: <cdcf19df902fbfa0632371f94309f21544cdad21.1340354986.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 06/22/2012 04:00 AM, Afzal Mohammed wrote:
> Helper function for updating nand platform data has been
> added the capability to take timing structure arguement.
> Usage of omap_nand_flash_init() has been replaced by modifed
> one, omap_nand_flash_init was doing things similar to
> board_nand_init except that NAND CS# were being acquired
> based on bootloader setting. As CS# is hardwired for a given
> board, acquiring gpmc CS# has been removed, and updated with
> the value on board.
> 
> NAND CS# used in beagle board was found to be CS0.
> Thomas Weber <thomas.weber.linux@googlemail.com> reported
> that value of devkit8000 to be CS0. Overo board was found
> to be using CS0 based on u-boot, while google grep says
> omap3touchbook too has CS0.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

Looks good.

Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
