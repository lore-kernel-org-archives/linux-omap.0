From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2 03/17] OMAP3: hwmod data: add DSS DISPC RFBI DSI VENC
Date: Mon, 20 Dec 2010 15:08:07 +0200
Message-ID: <1292850487.2421.46.camel@tubuntu>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
	 <1291031503-21036-4-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:57832 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372Ab0LTNIQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 08:08:16 -0500
In-Reply-To: <1291031503-21036-4-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: khilman@deeprootsystems.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hi,

On Mon, 2010-11-29 at 17:21 +0530, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Database generated for Display Sub System applicable for
> OMAP3430-ES2 onwards and OMAP36xx.
> dss is also considered as an IP as dispc,rfbi, and named as dss_dss.
> For all the IP modules in DSS, same clock is needed for enabling.
> hwmod sees as independent IPs, so same clock has to be
> repeated as .mainclk in each IP.
> OMAP3430ES1 do not have IDLEST bit to poll on for dss IP.  So this hwmod
> is not applicable for 3430ES1.

I'm not so familiar with hwmods, so I cannot comment much on the first
three patches in this series. I'll continue going through the latter
patches.

One question though: what does the mainclk do? If it means "a clock
which enables access to the registers", I'm not sure it's entirely
correct. The DSS clocking can be changed to get the functional clock
from DSI PLL.

Then a general comment about all the patches in the series: The commit
descriptions do not seem to be of very high quality. They are short and
poorly formatted. The descriptions are almost as important as the patch
itself.

Here's a nice text about commit messages:
http://who-t.blogspot.com/2009/12/on-commit-messages.html

And some comments of my own:
- Use capital letters for DSS, DISPC, etc. when not spesifically
referring to some variable or similar.
- Use space after comma.
- Wrap the lines consistently. Now it looks like the lines are wrapped
at random points in some commits.
- Use an empty line between paragraphs
- While I understand that you (me neither) are not native english
speaker, try to spend some time to be sure that there are no errors due
to carelessness.
- Remember that the 00 patch is not saved in git, so it should only be
an intro, and all the relevant information should be found in the actual
commit messages.

 Tomi


