From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH v3] OMAP: Fix for bus width which improves SD card's peformance.
Date: Thu, 8 Apr 2010 11:57:39 -0500
Message-ID: <003601cad73c$98c3aa50$544ff780@am.dhcp.ti.com>
References: <003b01cad0f0$6ea78040$544ff780@am.dhcp.ti.com> <g2s7f9d1ffb1003312331o149df218g651c3e4349ac9a77@mail.gmail.com> <003c01cad1b1$da2cdbf0$544ff780@am.dhcp.ti.com> <m2n7f9d1ffb1004050556o1ed2eec8ief66d60fc85f96de@mail.gmail.com> <20100405164839.GB17388@gandalf> <007c01cad4e4$26c5a700$544ff780@am.dhcp.ti.com> <20100406050035.GA32537@gandalf> <003901cad5a4$730264d0$544ff780@am.dhcp.ti.com> <20100406163211.GA29117@nokia.com> <4BBB6767.7010202@ti.com> <20100406165720.GA17916@nokia.com> <00b401cad5e0$1d1868d0$544ff780@am.dhcp.ti.com> <4BBBC628.9030207@ti.com> <00c901cad5e7$9de54350$544ff780@am.dhcp.ti.com> <4BBBD87C.1040307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBBD87C.1040307@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: 'Nishanth Menon' <nm@ti.com>
Cc: felipe.balbi@nokia.com, me@felipebalbi.com, 'kishore kadiyala' <kishorek.kadiyala@gmail.com>, 'Vimal Singh' <vimal.newwork@gmail.com>, tony@atomide.com, "'S, Venkatraman'" <svenkatr@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "'Lavinen Jarkko (Nokia-D/Helsinki)'" <jarkko.lavinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

<snip>
> Point noted. try n++:
> switch(mmc_slot(host).wires) {
> case 8:
>          mmc->caps |= MMC_CAP_8_BIT_DATA;
>          /* Fall through */
> case 4:
>          mmc->caps |= MMC_CAP_4_BIT_DATA;
>          break;
> case 0:
>          /* assuming nothing was given by board, use 1 */
> case 1:
>          /* nothing to crib here */
>          break;
> default:
>          /* Completely unexpected.. try 1 bit instead  */
>          dev_crit(mmc_dev(host->mmc), "Invalid width %d"
>                          " used! using 1 instead\n",
>                          mmc_slot(host).wires);
> }
> 
> note: we should crib if the board file made a mistake here.. say it gave
> 10 wire or so.. I agree that we can recover by stepping back to 1 bit
> mode.. but we gotta tell the log that something aint right..
> 

Sure. It looks fine to me now.

Regards,
Madhu
> --
> Regards,
> Nishanth Menon
