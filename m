From: pavan_savoy@indiatimes.com
Subject: Unable to request GPIO.
Date: Mon, 10 Nov 2008 22:55:56 +0530 (IST)
Message-ID: <306510209.444031226337956585.JavaMail.root@mbv7.indiatimes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from omta1.indiatimes.com ([203.199.93.122]:40999 "HELO
	omta1.indiatimes.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1753940AbYKJRdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 12:33:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I've added an entry in mux.c and mux.h of OMAP34xx platform for a GPIO 109, as MODE4 & PIN_OUTPUT, but I still cannot do a omap_request_gpio on the Pin [I've done a omap_cfg_reg], Always get a -16 error, which is EBUSY, I suppose, I couldn't find any other functionality on that GPIO [0x128 offset].

What could be the possible problems ?

regards,
Pavan Savoy.


--
Hyundai to launch the i20 in India. Catch the exclusive preview on ZigWheels.com
http://www.zigwheels.com/b2cam/newsDetails.action?name=Emb11_20080731&path=/INDT/News/Emb11_20080731&page=1&pagecount=2&utm_source=indmail&utm_medium=footer&utm_content=tracking&utm_campaign=Nletter_07oct2008_ZW
