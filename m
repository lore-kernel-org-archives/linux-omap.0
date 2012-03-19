From: Alex Tomas <bzzz.tomas@gmail.com>
Subject: is there way to control dss output bits?
Date: Mon, 19 Mar 2012 12:10:03 +0300
Message-ID: <CAOaPdDZw0yEXonpWkvr0Q+zNVzfC6myQPpjkE+k0Yg0ZFg7bkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60224 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754691Ab2CSJKE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 05:10:04 -0400
Received: by lahj13 with SMTP id j13so4550584lah.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 02:10:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm trying to build simple DAC to generate RGsB signal on a beagleboard.
say, the output is filled with green, then at "green" pins I get 1 all the time
while I'd like to get 0 while hsync/vsync are active. is it possible with OMAP?
I found UNUSEDBITS in the documentation, but that seem to be related to
RFBI and not to regular parallel output ?

thanks, Alex
