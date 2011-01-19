From: Ashok Babu <ashok3d@gmail.com>
Subject: Adio on BeagleBoard XM 2.6.37-rc8
Date: Wed, 19 Jan 2011 17:17:11 +0530
Message-ID: <AANLkTikPks0AcOpAK6We5zvju9k9qR=9z0-ua7qkKsLt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63760 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab1ASLrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 06:47:11 -0500
Received: by iwn9 with SMTP id 9so716954iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 03:47:11 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi folks,

After upgrading to 2.6.37-rc8, I am not able to play any audio.

Fund that the code in sound/soc/omap/omap-mcbsp.c uses the function
"cpu_is_omap343x()" which fails and returns ENODEV.

Does the call should be "cpu_is_omap34xx()" instead ?

Thanks & Regards
Ashok
