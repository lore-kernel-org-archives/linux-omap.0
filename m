From: "Rangasamy, Devaraj" <dev@ti.com>
Subject: RE: OMAP3 SYS_OFF_MODE support
Date: Thu, 24 Jul 2008 13:00:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022C1F60C5@dbde02.ent.ti.com>
References: <20080723134235.GB4543@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:42367 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbYGXHbF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2008 03:31:05 -0400
In-Reply-To: <20080723134235.GB4543@codecarver.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



sr_configure_vc() configures following things, which is needed to scale VDD1/VDD2 voltages while going RET/OFF during cpuidle.

- Voltage controller config : i2c bus details,voltage range and cmd range.
- Initializing PRM_VC_CMD_VAL_0, PRM_VC_CMD_VAL_1 with ON/RET/OFF voltage levels
- SYSOFF mode configuration of PRM_CLKSETUP, PRM_VOLTOFFSET, PRM_VOLTSETUP2

Its good to have it in prcm_init(),as we might lose this if smartreflex module is removed during compilation.


-----Original Message-----
From: Peter 'p2' De Schrijver [mailto:peter.de-schrijver@nokia.com]
Sent: Wednesday, July 23, 2008 7:13 PM
To: Rangasamy, Devaraj
Cc: TK, Pratheesh Gangadhar; linux-omap@vger.kernel.org
Subject: Re: OMAP3 SYS_OFF_MODE support

On Tue, Jul 22, 2008 at 07:56:10PM +0530, ext Rangasamy, Devaraj wrote:
>
> Currently sr_configure_vc() is the only dedicated API to configure Voltage controller parameter. But still SYSOFF specific configuration shall be moved to prcm init.
>

Do you suggest to move all the voltage control initialization to prcm
init ?

Cheers,

Peter.

--
goa is a state of mind
