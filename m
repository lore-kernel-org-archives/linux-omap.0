From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: nand: unify init functions
Date: Mon, 11 Jun 2012 10:43:45 -0500
Message-ID: <4FD61231.6020605@ti.com>
References: <cover.1339419244.git.afzal@ti.com> <95b5dece2f0b06ba1242f5af4c14fe1696950101.1339419244.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52065 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755686Ab2FKPny (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 11:43:54 -0400
In-Reply-To: <95b5dece2f0b06ba1242f5af4c14fe1696950101.1339419244.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

On 06/11/2012 09:01 AM, Afzal Mohammed wrote:
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

[1] also confirms the omap3-touchbook uses CS0.

> Signed-off-by: Afzal Mohammed <afzal@ti.com>

Which boards have been tested with this change?

Otherwise, looks good.

Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon

[1] http://www.alwaysinnovating.com/wiki/index.php/Booting
