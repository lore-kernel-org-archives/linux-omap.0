From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Doubts around SoC audio on omap3
Date: Mon, 16 Nov 2009 18:35:45 +0100
Message-ID: <70c9a9110911160935o7b8e4993tf8bcc1c1ec615786@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:6045 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbZKPRfl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 12:35:41 -0500
Received: by fg-out-1718.google.com with SMTP id d23so1324919fga.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 09:35:46 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I would like to add support for SoC audio on the IGEP v2 board but I
have some doubts about how to do. As I have seen in the source code,
the SoC driver for IGEP should be the same as omap3evm, overo and
cm-t35.

So, is better to use the solution adopted by the board CM-T35 or add a
specific file for the board IGEP like omap3evm board ?

Is there any difference between the omap3evm driver and the overo driver ?

Thanks in advance,

Enric
