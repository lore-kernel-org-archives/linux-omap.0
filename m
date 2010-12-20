From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v2 03/17] OMAP3: hwmod data: add DSS DISPC RFBI DSI VENC
Date: Mon, 20 Dec 2010 22:13:59 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F3AC430@dbde02.ent.ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
	 <1291031503-21036-4-git-send-email-svadivu@ti.com>
 <1292850487.2421.46.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50980 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932512Ab0LTQoM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 11:44:12 -0500
In-Reply-To: <1292850487.2421.46.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

linux-omap-owner@vger.kernel.org wrote:
> Hi,
> 
> On Mon, 2010-11-29 at 17:21 +0530, ext Guruswamy Senthilvadivu wrote:
>> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>> 
>> Database generated for Display Sub System applicable for
>> OMAP3430-ES2 onwards and OMAP36xx.
>> dss is also considered as an IP as dispc,rfbi, and named as dss_dss.
>> For all the IP modules in DSS, same clock is needed for enabling.
>> hwmod sees as independent IPs, so same clock has to be repeated as .mainclk
>> in each IP. OMAP3430ES1 do not have IDLEST bit to poll on for dss IP.  So
>> this hwmod is not applicable for 3430ES1.
> 
> I'm not so familiar with hwmods, so I cannot comment much on
> the first three patches in this series. I'll continue going
> through the latter patches.
> 
> One question though: what does the mainclk do? If it means "a
> clock which enables access to the registers", I'm not sure
> it's entirely correct. The DSS clocking can be changed to get
> the functional clock from DSI PLL.

On OMAP4 there are MODULEMODE bits for DSS and other domains,
these need to be enabled to use the module, I think that's what
mainclk represents here.

You can have a look at the CM_DSS_DSS_CLKCTRL register in the OMAP4 TRM
to get a better idea.

So, instead of explicitly enabling/disabling the interface clocks
like we did for DSS in omap3, we just need to ensure that MODULEMODE
bits are set, setting this will take care of enabling/gating interface
clocks based on the state of the clock domain.

I think we consider the DSS1_ALWAYSON_FCK as the mainclk.

Others, please correct me if I am wrong.

Regards,
Archit

>
> Then a general comment about all the patches in the series:
> The commit descriptions do not seem to be of very high
> quality. They are short and poorly formatted. The
> descriptions are almost as important as the patch itself.
> 
> Here's a nice text about commit messages:
> http://who-t.blogspot.com/2009/12/on-commit-messages.html
> 
> And some comments of my own:
> - Use capital letters for DSS, DISPC, etc. when not
> spesifically referring to some variable or similar.
> - Use space after comma.
> - Wrap the lines consistently. Now it looks like the lines
> are wrapped at random points in some commits.
> - Use an empty line between paragraphs
> - While I understand that you (me neither) are not native
> english speaker, try to spend some time to be sure that there
> are no errors due to carelessness.
> - Remember that the 00 patch is not saved in git, so it
> should only be an intro, and all the relevant information
> should be found in the actual commit messages.
> 
>  Tomi