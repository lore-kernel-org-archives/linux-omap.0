From: Belisko Marek <marek.belisko@gmail.com>
Subject: DSS display-new custom enable/disable hooks
Date: Tue, 24 Sep 2013 22:04:08 +0200
Message-ID: <CAAfyv349Xjt7Wy-R34OW81SzmUX-1WhfVZdbhWVDoOXpUKa9ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:56503 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3IXUEL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 16:04:11 -0400
Received: by mail-oa0-f43.google.com with SMTP id f4so2688191oah.2
        for <linux-omap@vger.kernel.org>; Tue, 24 Sep 2013 13:04:08 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

we're using connector-analog-tv driver to enable TV out on gta04
board. There is exception that we need to change some twl registers +
some gpio when enable/disable TV output. My question is if there is
some way how to do that or do we need to copy'n'paste code from
connector-analog-tv driver and extend it for handling we need (let's
call it hack)?

Thanks,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
