From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [alsa-devel] [PATCHv3 1/7] OMAP4: PMIC: Add support for twl6030
 codec
Date: Wed, 7 Oct 2009 11:56:38 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB056090@dbde02.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90C2F648@dlee04.ent.ti.com>
 <200910061146.05080.peter.ujfalusi@nokia.com>
 <20091006163546.GA11062@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46778 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbZJGG12 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 02:27:28 -0400
In-Reply-To: <20091006163546.GA11062@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <x0052729@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

(Looping Samuel)
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Mark Brown
> Sent: Tuesday, October 06, 2009 10:06 PM
> To: Peter Ujfalusi
> Cc: alsa-devel@alsa-project.org; Lopez Cruz, Misael; linux-
> omap@vger.kernel.org; Krishnamoorthy, Balaji T
> Subject: Re: [alsa-devel] [PATCHv3 1/7] OMAP4: PMIC: Add support for
> twl6030 codec
> 
> On Tue, Oct 06, 2009 at 11:46:05AM +0300, Peter Ujfalusi wrote:
> 
> > How does the twl4030 series would fit with this modification?
> > I have also added the twl4030 codec as a child for the twl MFD, but I
> have not
> > finished the cleanup of the codec fully.
> 
> The TWL6030 specific bits all look good but this change ought to go via
> the MFD tree (probably as part of the big patch series adding twl6030
> support that doesn't look to have been applied yet).  Are people happy
> that the interface to the twl6030 won't change as a result of the
> twl4030 audio support?  If so then I'll apply the ASoC side now, the
> Kconfig dependencies will stop it being built too soon.
Since there is some sort of dependency on ASOC series with TWL_6030 core series by Balaji, its better that these gets merged in correct order to avoid reworks. 

Below order should make the merge without many conflicts.
1. [PATCH v3 0/4] TWL patch series
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg17059.html

2. [PATCH v3 0/4] TWL6030 patch series
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg17130.html

3. [PATCHv3 0/7] TWL6030 audio codec initial support + Rework the Kconfig dependency. 
http://www.spinics.net/lists/alsa-devel/msg28134.html

Samuel can take a call on this.


Regards,
Santosh
