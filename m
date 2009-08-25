From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2 2/4] RTC MSECURE: msecure initialization
Date: Wed, 26 Aug 2009 00:00:46 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F996ECDE@dbde02.ent.ti.com>
References: <1251126434-27191-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37897 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755456AbZHYSaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Aug 2009 14:30:55 -0400
In-Reply-To: <1251126434-27191-1-git-send-email-charu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charu Latha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>

Charu -- possible bug

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Varadarajan, Charu Latha
> /*
>+ * msecure line initialisation for TWL4030 RTC registers write access
>+ */
>+static int msecure_init(struct twl4030_rtc_platform_data *pdata)
>+{
>+	int ret = 0;
>+	if (pdata == NULL)
>+		goto out;
>+
>+	ret = gpio_request(pdata->msecure_gpio, "msecure");

What about other boards like: Beagle, EVM, Pandora, Zoom2, RX51
What about SDP/LDP with OMAP ES2.1 and above

For these boards, there is no msecure_gpio defined. 

What would be the value for msecure_gpio for these boards?


>+	if (ret) {
>+		pr_err("twl4030_rtc: can't reserve msecure GPIO:%d !\n"
>+			"RTC functionality will not be available\n",
>+			pdata->msecure_gpio);
>+		goto out;
>+	}
>+	/*
>+	 * TWL4030 will be in secure mode if msecure line from OMAP is low.
>+	 * Make msecure line high in order to change the TWL4030 RTC time
>+	 * and calender registers.
>+	 */
