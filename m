From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 01/39] ARM: OMAP2+: gpmc: driver conversion
Date: Tue, 8 May 2012 06:18:37 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9878EC@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <363273a9ef82d6836197929157aa9a8eb8f5171a.1335874494.git.afzal@ti.com>
 <4FA4035E.6020308@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987147@DBDE01.ent.ti.com>
 <4FA7F232.7050802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49381 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437Ab2EHGTG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 02:19:06 -0400
In-Reply-To: <4FA7F232.7050802@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Menon, Nishanth" <nm@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "notasas@gmail.com" <notasas@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "vimal.newwork@gmail.com" <vimal.newwork@gmail.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Hire

Hi Jon,

On Mon, May 07, 2012 at 21:32:58, Hunter, Jon wrote:

> >>> +	/* no waitpin */
> >>> +	case 0:
> >>> +		break;
> >>> +	default:
> >>> +		dev_err(gpmc->dev, "multiple waitpins selected on CS:%u\n", cs);
> >>> +		return -EINVAL;
> >>> +		break;
> >>> +	}
> >>
> >> Why not combined case 0 and default? Both are invalid configurations so
> >> just report invalid selection.
> > 
> > Case 0 is not invalid, a case where waitpin is not used, default refers
> > to when a user selects multiple waitpins wrongly.
> 
> Ok. Then for case 0, just return here. If the polarity is set, you could
> print an error here.

Different ways of doing things, this looks cleaner to me as already it is
checked, and time of execution in both cases would not differ much.

> >>> +		if (gd->have_waitpin) {
> >>> +			if (gd->waitpin != idx ||
> >>> +					gd->waitpin_polarity != polarity) {
> >>> +				dev_err(gpmc->dev, "error: conflict: waitpin %u with polarity %d on device %s.%d\n",
> >>> +					gd->waitpin, gd->waitpin_polarity,
> >>> +					gd->name, gd->id);
> >>> +				return -EBUSY;
> >>> +			}
> >>> +		} else {
> >>
> >> Don't need the else as you are going to return in the above.
> > 
> > Not always, only in case of error
> 
> Ok, but seems that it can be simplified a little.
> 
> What happens if a device uses more than one wait-pin? In other words a
> device with two chip-selects that uses two wait-pins?

Please re-read http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67702.html
and your reply

Regards
Afzal
