From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: omap3505: HECC support and DT ?
Date: Thu, 11 Dec 2014 15:44:06 +0100
Message-ID: <CAL8zT=izk+xk=v0M0F5DSgSySaGvkPWWZdCd43i8Z6bwQt7MAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:62694 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406AbaLKOoV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2014 09:44:21 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so3290883obc.1
        for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2014 06:44:21 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nm@ti.com

Hi !

I have a custom board with a AM3505.
I am trying to use linux 3.18 and I have difficulties making it work.
What is needed in order to get it declared in DT ?
Is it still needed to have a board-am3517-myboard.c ?

I have a few drivers like that I need to bring up (a Micrel KSZ8873
for example) where the drivers exist, but a DT binding seems to be
missing.
But I may have missed the information, hence my question :).

Thanks in advance,
JM
