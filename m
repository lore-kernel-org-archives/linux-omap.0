From: "Steve Sakoman" <sakoman@gmail.com>
Subject: ALSA SoC for TWL4030
Date: Thu, 15 May 2008 08:18:35 -0700
Message-ID: <5e088bd90805150818h1c2a5d8ep263811c8baed333a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:55061 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536AbYEOPSl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 11:18:41 -0400
Received: by fk-out-0910.google.com with SMTP id 18so347005fkq.5
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 08:18:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm thinking of tackling audio support for the OMAP3 EVM next.

I'd like to make sure that I'm not duplicating work :-)

Is anyone aware of any existing efforts to support the TWL4030 audio
functionality?  I've seen the TI work in the 2.6.22 kernel, but it is
not an SoC driver and seems to use a different mcbsp implementation
than is in the current linux-omap tree.

Regards,

Steve
