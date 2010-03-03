From: Mai Daftedar <mai.daftedar@gmail.com>
Subject: Smart Reflex Patch Fix
Date: Wed, 3 Mar 2010 16:14:31 +0200
Message-ID: <2cd4ff051003030614h7fce7f80p88933218030e228d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:60499 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab0CCOOc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 09:14:32 -0500
Received: by ewy20 with SMTP id 20so935374ewy.21
        for <linux-omap@vger.kernel.org>; Wed, 03 Mar 2010 06:14:31 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,
=A0=A0 I need some help I have the following problem my working
environement is the beagleboard running android. After enabling the
ondemand governor and =A0running the (userspace-application) for a whil=
e
the board prints the following:
=A0=A0=A0=A0=A0=A0 =A0=A0=A0SR2:VDD autocomp is not active
=A0=A0=A0=A0=A0 =A0=A0=A0=A0and simply halts!!!..

I thought of a solution by patching the linux kernel, however I dont
know where to head.Can anyone please help?


Thanks
Best Regards
Mai
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
