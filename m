From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH] omap-pm: Fixes behaviour of some shared resource
 framework functions
Date: Thu, 29 Oct 2009 20:22:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE16F1FC@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE4650@dbde02.ent.ti.com><87iqejktan.fsf@deeprootsystems.com><alpine.DEB.2.00.0910281236270.19865@utopia.booyaka.com><003201ca581b$256863c0$544ff780@am.dhcp.ti.com>
 <87hbtj3zpc.fsf@deeprootsystems.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE16EE0D@dbde02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA9DDEF056E@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47484 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbZJ2OwJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 10:52:09 -0400
In-Reply-To: <74583B8642AB8841B30447520659FCA9DDEF056E@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: 'Paul Walmsley' <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Titiano, Patrick" <p-titiano@ti.com>, "Turquette, Mike" <mturquette@ti.com>

Hello Benoit,
                        One comment below:
> 
> In fact, this is Mike who started that analysis. We discussed that internally and
> our point is that if the CPUFreq ondemand or conservative heuristic is not able
> to increase quickly enough the CPU need to handle correctly the UI, we have
> to somehow improve or modify the governor in order to provide it a extra
> information in term of constraint maybe in order to increase immediately the
> frequency.
The information as you mention needs to be supplied by the driver. The governor would then act on behalf of the driver! 
This begs for a new governor API or a signature change to an existing governor API.
> 
> This should not be done in the low level omap_pm code; this is not the right
> level to do that. The issue is in the ondemand and must be fixed there.
> 
At the end of the day it would still be the driver making the decision! 

Regards,
-Romit


