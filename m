From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: [PATCH v2 2/4] RTC MSECURE: msecure initialization
Date: Wed, 26 Aug 2009 10:46:57 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ACEA@dbde02.ent.ti.com>
References: <1251126434-27191-1-git-send-email-charu@ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F996ECDE@dbde02.ent.ti.com>,<19F8576C6E063C45BE387C64729E73940436A49FB1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57971 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754074AbZHZFRJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Aug 2009 01:17:09 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436A49FB1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Vikram,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> Sent: Wednesday, August 26, 2009 12:01 AM
> To: Varadarajan, Charu Latha; linux-omap@vger.kernel.org
> Cc: tony@atomide.com; david-b@pacbell.net; sameo@linux.intel.com;
> p_gortmaker@yahoo.com
> Subject: RE: [PATCH v2 2/4] RTC MSECURE: msecure initialization
>
> Charu -- possible bug
>
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of
> >Varadarajan, Charu Latha
> > /*
> >+ * msecure line initialisation for TWL4030 RTC registers write access
> >+ */
> >+static int msecure_init(struct twl4030_rtc_platform_data *pdata)
> >+{
> >+    int ret = 0;
> >+    if (pdata == NULL)
> >+            goto out;
> >+
> >+    ret = gpio_request(pdata->msecure_gpio, "msecure");
>
> What about other boards like: Beagle, EVM, Pandora, Zoom2, RX51
> What about SDP/LDP with OMAP ES2.1 and above
>
> For these boards, there is no msecure_gpio defined.
>
> What would be the value for msecure_gpio for these boards?
For the twl4030 based boards which don't have msecure gpio lines, the rtc platform data
need to be null. The same was addressed in version 1 patch and it has been agreed that
the default value is NULL and hence need not be initialized in board files.
This patch is tested on SDP boards with silicon version 3.1.
>
>
> >+    if (ret) {
> >+            pr_err("twl4030_rtc: can't reserve msecure GPIO:%d !\n"
> >+                    "RTC functionality will not be available\n",
> >+                    pdata->msecure_gpio);
> >+            goto out;
> >+    }
> >+    /*
> >+     * TWL4030 will be in secure mode if msecure line from OMAP is low.
> >+     * Make msecure line high in order to change the TWL4030 RTC time
> >+     * and calender registers.
> >+     */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

