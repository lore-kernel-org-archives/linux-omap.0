From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 10/14] ARM: OMAP2+: gpmc: waitpin helper
Date: Thu, 14 Jun 2012 16:06:26 -0500
Message-ID: <4FDA5252.2050401@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <bba49a35f81f33fbdfeda78a71cbe4aa3417d6a2.1339419492.git.afzal@ti.com> <4FD6783D.9030208@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997F7C@DBDE01.ent.ti.com> <4FD78748.2080504@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E998955@DBDE01.ent.ti.com> <4FD8B55E.6010701@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9996FC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51593 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220Ab2FNVGW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 17:06:22 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9996FC@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 06/14/2012 03:48 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Wed, Jun 13, 2012 at 21:14:30, Hunter, Jon wrote:
>> On 06/13/2012 02:37 AM, Mohammed, Afzal wrote:
> 
>>> In that case we would be directly depending on user flag whose value may
>>> or may not change and I don't think it is good to directly depend on it
>>> for waitpin # calculation.
>>
>> You are already dependent on it. In other words, you are going to set
> 
> What I meant is we are not dependent on absolute value of flag to
> find waitpin, and I disagree in depending on its absolute value,
> which can change, while flag would be the same.

As long as we can avoid having multiple #defines for the same thing, I
don't mind how it is done.

Jon
