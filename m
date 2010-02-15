From: tarek attia <tarek.m.attia@gmail.com>
Subject: CpuFreq doesn't change the beagleboard voltage
Date: Tue, 16 Feb 2010 00:22:19 +0200
Message-ID: <82cfbe861002151422s40d671d9wf8e1d78e86560c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:47885 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab0BOWWV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 17:22:21 -0500
Received: by ewy28 with SMTP id 28so806308ewy.28
        for <linux-omap@vger.kernel.org>; Mon, 15 Feb 2010 14:22:20 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi all,
I'm using the rowboat project(Android over beagleboard),and I have
enabled=A0the CPUFREQ kernel driver,and I can switch between the
different=A0frequencies,however when I measure the current consumed ,I
found that in some certain OP,the current=A0remains=A0constant without =
any
change in it's value,however all the other frequencies just minor
change in the current consumed
So any Idea,,Am I missing anything to enable ?????


Appreciate your help ..
--
tarek
--
tarek
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
