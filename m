From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 1/3] ARM: OMAP2+: nand: unify init functions
Date: Tue, 26 Jun 2012 08:35:10 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99F02D@DBDE01.ent.ti.com>
References: <cover.1340354985.git.afzal@ti.com>
 <cdcf19df902fbfa0632371f94309f21544cdad21.1340354986.git.afzal@ti.com>
 <4FE883F5.6040806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39162 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758245Ab2FZIfS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 04:35:18 -0400
In-Reply-To: <4FE883F5.6040806@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Mon, Jun 25, 2012 at 20:59:57, Hunter, Jon wrote:
> On 06/22/2012 04:00 AM, Afzal Mohammed wrote:
> > Helper function for updating nand platform data has been
> > added the capability to take timing structure arguement.
> > Usage of omap_nand_flash_init() has been replaced by modifed
> > one, omap_nand_flash_init was doing things similar to
> > board_nand_init except that NAND CS# were being acquired
> > based on bootloader setting. As CS# is hardwired for a given
> > board, acquiring gpmc CS# has been removed, and updated with
> > the value on board.
> > 
> > NAND CS# used in beagle board was found to be CS0.
> > Thomas Weber <thomas.weber.linux@googlemail.com> reported
> > that value of devkit8000 to be CS0. Overo board was found
> > to be using CS0 based on u-boot, while google grep says
> > omap3touchbook too has CS0.

> Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Thanks,
Afzal
