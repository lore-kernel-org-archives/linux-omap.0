From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [RFC] OMAP DT i2c aliases
Date: Sun, 01 Jun 2014 17:28:07 +0300
Message-ID: <538B3877.70304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40331 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbaFAO2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Jun 2014 10:28:12 -0400
Received: by mail-wg0-f44.google.com with SMTP id a1so4005450wgh.27
        for <linux-omap@vger.kernel.org>; Sun, 01 Jun 2014 07:28:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, sre@kernel.org

Hi,

patch https://lkml.org/lkml/2013/10/16/744 fixes DT i2c bus ids in case 
of deferred probe and assigns id 0,1 and 2 for i2c buses 1,2 and 3. 
Unfortunately, this breaks Maemo userspace on N900, where board code (in 
case of legacy boot) assigns ids 1, 2 and 3, but with DT boot ids are 
0,1 and 2. I've already send a patch https://lkml.org/lkml/2014/6/1/49 
that will allow me to fix that from board .dts, but I was wondering if 
it is the correct way, or ids should be changed in omap3.dtsi for all 
omap devices.

Regards,
Ivo
