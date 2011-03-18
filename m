From: "Premi, Sanjeev" <premi@ti.com>
Subject: FW: omap2+ voltage: Few queries
Date: Fri, 18 Mar 2011 10:19:38 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C3084C7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59059 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074Ab1CREtq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2011 00:49:46 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Hi all,
 
While trying to understand the voltage layer, i have few comments and
doubts. This is not a comprehensive list, but for starters:
 
1) Functions omap3_voltage_read_reg(), omap3_voltage_write_reg()
   which in turn call omap2_prm_read_mod_reg and omap2_prm_write_mod_reg() 
 
   These functions are always called via function pointer contained
   in "omap_vdd_info".
 
   What is the need for additional layer?
   shouldn't be just do the following:
 
     vdd->read_reg = omap2_prm_read_mod_reg ;
     vdd->write_reg = omap2_prm_write_mod_reg  ;
 
   Same holds good for similar functions for OMAP4.
 
2) Structure omap_volt_data is used to describe the nominal voltage
   for each OPP, However, presence of sr_efuse_offs, sr_errminlimit,
   vp_errgain make assumptions on presence of SmartReflex and VP.
 
   Value "0" to these fields cannot safely be used to indicate the
   "not used" status - esp for sr_xx fields.
 
   Shouldn't we delink them. something like:
 
   struct omap_volt_data {
        u32 volt_nominal;
    u8 vp_errgain; /* Assuming that value "0" is equiv to "not used" */
    struct volt_sr_data* sr_data;
   }
 
3) Struct "omap_volt_pmic_info" should be trimmed to keep only PMIC
   related info. Will make it easier to add support for other PMICs.
 
   Suggestion:
 
   struct omap_pmic_info {
    int slew_rate;
    int step_size;

    u8 i2c_slave_addr;
    u8 pmic_reg;
    struct omap_pmic_extra_info * extra;
    unsigned long (*vsel_to_uv) (const u8 vsel);
    u8 (*uv_to_vsel) (unsigned long uV);
    };
 
   BTW, what does the PMIC register indicate? target addr on PMIC?
 
/* Not all PMICs would be able to support these features */
   struct omap_pmic_extra_info {

    u32 on_volt;
    u32 onlp_volt;
    u32 ret_volt;
    u32 off_volt;

    };
 
   "extra" is just random name, even "aux" standing for "auxilliary"
   should do.
 
   struct omap_vp_info { /* just random name for this mail only */
    u8 vp_erroroffset;
    u8 vp_vstepmin;
    u8 vp_vstepmax;
    u8 vp_vddmin;
    u8 vp_vddmax;
    u8 vp_timeout_us;
    };
 
   Can this/ Should this be combined with an existing structure?
   e.g. omap_vp_common_data?
 
I have some work-in-progress changes. Based on the responses, i will
tailor them and send across tomorrow.
 
Best regards,
Sanjeev

(folks in cc: sorry for resend. Original mail in
              was mistakenly sent in HTML format;
              and not delivered to the list)
         