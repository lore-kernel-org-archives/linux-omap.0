From: Joni Lapilainen <joni.lapilainen@gmail.com>
Subject: bq27x00_battery broken
Date: Sat, 22 Sep 2012 06:01:52 +0300
Message-ID: <CAOSRfZ6p6Q5MHYmwKs4_K9yzYoN1Ap=dQz6UAH0Ohn4JWNPU0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35345 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab2IVDBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 23:01:54 -0400
Received: by eaac11 with SMTP id c11so1266684eaa.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 20:01:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Commit a66f59ba2e994bf70274ef0513e24e0e7ae20c63 broke bq27x00_battery
on N900. When module is loaded, it starts flooding logs and console
with error "power_supply bq27200-0: driver failed to report 'temp'
property: 4294964565". Tested with reverting commit previously
mentioned and it functions normally.
