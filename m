From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH v2 1/1] OMAP3: rx-51: Add full regulator definitions
Date: Thu, 12 May 2011 08:59:51 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B09F26B@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1304317733-9639-1-git-send-email-kalle.jokiniemi@nokia.com>
	<1304317733-9639-2-git-send-email-kalle.jokiniemi@nokia.com>
 <20110502095825.05515db9.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:56490 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab1ELJAI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 05:00:08 -0400
In-Reply-To: <20110502095825.05515db9.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: broonie@opensource.wolfsonmicro.com, linux-omap@vger.kernel.org, jhnikula@gmail.com

Hi Tony,

 > -----Original Message-----
 > From: ext Jarkko Nikula [mailto:jhnikula@gmail.com]
 > Sent: 2. toukokuuta 2011 9:58
 > To: Jokiniemi Kalle (Nokia-SD/Tampere)
 > Cc: tony@atomide.com; broonie@opensource.wolfsonmicro.com; linux-
 > omap@vger.kernel.org
 > Subject: Re: [PATCH v2 1/1] OMAP3: rx-51: Add full regulator definitions

Did this one get pushed to linux-omap? Just checking on my old patches...

- Kalle


 > 
 > On Mon,  2 May 2011 09:28:53 +0300
 > Kalle Jokiniemi <kalle.jokiniemi@nokia.com> wrote:
 > 
 > > The vaux2 (VCSI) regulator is left on by the bootloader
 > > in rx-51. Since there the product has shipped and there
 > > won't be any bootloader updates to fix this issue, we
 > > need to define all the regulators and declare full
 > > constraints for the regulator FW. This will allow the
 > > regulator FW to disable unused regulators.
 > >
 > > Also this helps in adding more fine grain regulator
 > > support for rx-51 in the future.
 > >
 > > Thanks for Mark Brown for pointing out the correct
 > > solution.
 > >
 > > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
 > > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
 > > ---
 > 
 > Reviewed-by: Jarkko Nikula <jhnikula@gmail.com>



