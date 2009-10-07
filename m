From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [alsa-devel] [PATCHv3 1/7] OMAP4: PMIC: Add support for twl6030
 codec
Date: Wed, 7 Oct 2009 15:10:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB05624E@dbde02.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90C2F648@dlee04.ent.ti.com>
 <200910061146.05080.peter.ujfalusi@nokia.com>
 <20091006163546.GA11062@rakim.wolfsonmicro.main>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB056090@dbde02.ent.ti.com>
 <20091007093717.GA3169@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33098 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757351AbZJGJlr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 05:41:47 -0400
In-Reply-To: <20091007093717.GA3169@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <x0052729@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, October 07, 2009 3:07 PM
> To: Shilimkar, Santosh
> Cc: Peter Ujfalusi; sameo@linux.intel.com; alsa-devel@alsa-project.org;
> Lopez Cruz, Misael; linux-omap@vger.kernel.org; Krishnamoorthy, Balaji T
> Subject: Re: [alsa-devel] [PATCHv3 1/7] OMAP4: PMIC: Add support for
> twl6030 codec
> 
> On Wed, Oct 07, 2009 at 11:56:38AM +0530, Shilimkar, Santosh wrote:
> 
> [I've reflowed your mail to fit into 80 columns]
> 
> > Since there is some sort of dependency on ASOC series with TWL_6030
> > core series by Balaji, its better that these gets merged in correct
> > order to avoid reworks.
> 
> There's no ordering problem with ASoC providing the TWL6030 core patches
> add the TWL6030_CORE symbol as the last thing in the merge.  None of the
> ASoC drivers will be built until that symbol is defined so the absence
> of the core shouldn't matter.
OK. 

Regards,
Santosh
