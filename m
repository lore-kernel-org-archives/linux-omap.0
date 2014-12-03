From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: OMAPDSS: HDMI: Add OMAP5 HDMI support
Date: Wed, 3 Dec 2014 15:22:02 +0300
Message-ID: <20141203122202.GA7398@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42348 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaLCMWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2014 07:22:13 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org

Hello Tomi Valkeinen,

The patch f5bab2229190: "OMAPDSS: HDMI: Add OMAP5 HDMI support" from
Mar 13, 2014, leads to the following static checker warning:

	drivers/video/fbdev/omap2/dss/hdmi5_core.c:719 hdmi5_core_audio_config()
	warn: '(3) - (4)' negative one

Uh...  This is really weird, I have no idea what this warning is or why
it's triggered.  I've even looked at the code which triggers it but that
has no documentation.  :P  Still it seems like something worth looking
into.

drivers/video/fbdev/omap2/dss/hdmi5_core.c
   713          /* PCM audio mode */
   714          val = (cfg->iec60958_cfg->status[0] & IEC958_AES0_CON_MODE) >> 6;
   715          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(2), val, 6, 4);
   716  
   717          /* Source number */
   718          val = cfg->iec60958_cfg->status[2] & IEC958_AES2_CON_SOURCE;
   719          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(2), val, 3, 4);
                                                                  ^^^^
Aren't these reversed?  This seems like an invalid bitfield range.

   720  
   721          /* Channel number right 0  */
   722          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(3), 2, 3, 0);
   723          /* Channel number right 1*/
   724          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(3), 4, 7, 4);
   725          /* Channel number right 2  */
   726          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(4), 6, 3, 0);
   727          /* Channel number right 3*/
   728          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(4), 8, 7, 4);
   729          /* Channel number left 0  */
   730          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(5), 1, 3, 0);
   731          /* Channel number left 1*/
   732          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(5), 3, 7, 4);
   733          /* Channel number left 2  */
   734          REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCHNLS(6), 5, 3, 0);
   735          /* Channel number left 3*/

regards,
dan carpenter
