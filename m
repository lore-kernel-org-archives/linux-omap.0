From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
Date: Thu, 8 Mar 2007 23:18:05 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C476F289D@dlee13.ent.ti.com>
References: <9C23CDD79DA20A479D4615857B2E2C476F289B@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C476F289B@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>, kmpark@infradead.org, Pierre Ossman <drzeus@drzeus.cx>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Sorry, small correction. It can support from 0 to 26 Mhz or 0 to 52 Mhz
We should be able to configure 48Mhz.

Regards,
Khasim

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
>open-source-bounces@linux.omap.com] On Behalf Of Syed Mohammed, Khasim
>Sent: Thursday, March 08, 2007 11:11 PM
>To: kmpark@infradead.org; Pierre Ossman
>Cc: linux-omap-open-source@linux.omap.com
>Subject: RE: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
>
>Hi Kyungmin,
>
>I haven't gone through the entire code as such, here is my
>understanding.
>
>>So if the the csd->mmca_vsn is CSD_SPEC_VER_4 then it always set
>highspeed.
>Yes, if card is 4.0 compliant then it's HS Card.
>
>>then what makes the highspeed enabled? host or card?
>Both - right? First controller should support such clock rates, and
card
>should be 4.0 (or more) compliant.
>
>>If the host supports up to 48MHz clock and card supports the
highspeed.
>>then what's the correct clock?
>If controller supports upto 48Mhz then I think we can only support
26Mhz
>max. There are some special bits in 2430 processor to support 52 Mhz
>
>According to spec, a card can support both 52 & 26 or 26 (0x1 or 0x3).
>So, if our controller doesn't support 52Mhz clock rates then we should
>stick to 26Mhz.
>
>Regards,
>Khasim
>
>>-----Original Message-----
>>From: Kyungmin Park [mailto:kmpark@infradead.org]
>>Sent: Thursday, March 08, 2007 8:42 PM
>>To: Syed Mohammed, Khasim; 'Pierre Ossman'
>>Cc: linux-omap-open-source@linux.omap.com
>>Subject: RE: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
>>
>>Hi Khasim,
>>
>>I checked the mmc code in linux-2.6.14-omap2420-omap2430. It is used
>the
>>old samsung patch (mmcplus) in mmc core.
>>So if the the csd->mmca_vsn is CSD_SPEC_VER_4 then it always set
>highspeed.
>>the follwing code is always true if the chip is correct.
>>
>>              if ((ext_csd->card_type & MMCPLUS_26MHZ) || (ext_csd-
>>>card_type & MMCPLUS_52MHZ)) {
>>                        err =3D mmc_switch_hsmode(host, card);
>>                        if (err !=3D MMC_ERR_NONE) {
>>                                mmc_card_set_dead(card);
>>                                continue;
>>                        }
>>                }
>>
>>then what makes the highspeed enabled? host or card?
>>If the host supports up to 48MHz clock and card supports the
highspeed.
>>then what's the correct clock?
>>
>>Currently if we don't set HIGHSPPED flags, it always set 20MHz as in
>the
>>Spec. Since it is calculated from card->csd.max_dtr in
>>mmc_calculate_clock().
>>
>>        list_for_each_entry(card, &host->cards, node)
>>                if (!mmc_card_dead(card)) {
>>                        if (mmc_card_highspeed(card) &&
>mmc_card_sd(card))
>>{
>>                                if (max_dtr >
card->sw_caps.hs_max_dtr)
>>                                        max_dtr =3D
>card->sw_caps.hs_max_dtr;
>>                        } else if (mmc_card_highspeed(card) &&
>>!mmc_card_sd(card)) {
>>                                if (max_dtr >
card->ext_csd.hs_max_dtr)
>>                                        max_dtr =3D
>card->ext_csd.hs_max_dtr;
>>                        } else if (max_dtr > card->csd.max_dtr) {
>>                                max_dtr =3D card->csd.max_dtr;
>>                        }
>>                }
>>
>>Okay I will check the MMC Spec.
>>
>>Thank you,
>>Kyungmin Park
>>
>>
>>________________________________
>>
>>	From: Syed Mohammed, Khasim [mailto:x0khasim@ti.com]
>>	Sent: Thursday, March 08, 2007 9:02 PM
>>	To: kmpark@infradead.org; Pierre Ossman
>>	Cc: linux-omap-open-source@linux.omap.com
>>	Subject: RE: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
>>
>>
>>	Hi Kyungmin,
>>
>>	OMAP2420 doesn't support High Speed. OMAP2430 does support
>>Highspeed.
>>
>>	Please see our code for 2430 (its on linux.omap.com).
>>
>>	Regards,
>>	Khasim
>>
>>________________________________
>>
>>	From: linux-omap-open-source-bounces@linux.omap.com on behalf of
>>Kyungmin Park
>>	Sent: Thu 3/8/2007 1:28 AM
>>	To: 'Pierre Ossman'
>>	Cc: linux-omap-open-source@linux.omap.com
>>	Subject: RE: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
>>
>>
>>
>>
>>	> Do _not_ take these flags lightly. If you enable them when
>>	> the hardware doesn't support the alternative timing, you have
>>	> a good chance of cards not working. So to me this looks very
>>	> wrong as the pre-48MHz controllers probably only follow the
>>	> legacy timing requirements.
>>	>
>>
>>	I'm not sure OMAP2 MMC supports highspeed feature. I can't find
>>anytings in
>>	OMAP2 TRM.
>>
>>	        if (cpu_class_is_omap2())
>>	                mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED |
>>MMC_CAP_SD_HIGHSPEED;
>>
>>	mmc0: selected 48.000MHz transfer rate
>>	mmc0: clock 48000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2
>>timing 1
>>
>>	Then is it dependent on platform?
>>
>>	        if (minfo->highspeed)
>>	                mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED |
>>MMC_CAP_SD_HIGHSPEED;
>>
>>	And even though we set HIGHSPEED, the card set their clock
>>correctly. Is it
>>	right?
>>
>>	mmc0: selected 26.000MHz transfer rate
>>	mmc0: clock 26000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2
>>timing 1
>>
>>	Thank you,
>>	Kyungmin Park
>>
>>	_______________________________________________
>>	Linux-omap-open-source mailing list
>>	Linux-omap-open-source@linux.omap.com
>>	http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>>
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
