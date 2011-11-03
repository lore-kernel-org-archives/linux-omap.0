From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2] arm: omap: Fix errors and warnings when building for
 one board
Date: Thu, 03 Nov 2011 19:45:34 +0100
Message-ID: <4EB2E14E.1040505@gmail.com>
References: <1318522450-18425-1-git-send-email-premi@ti.com> <E28AAFD00EFAA646AE3DF9B89CD24A8901CD80@DBDE01.ent.ti.com> <20111103182631.GT31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55295 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933609Ab1KCSpo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 14:45:44 -0400
Received: by eye27 with SMTP id 27so1426375eye.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Nov 2011 11:45:43 -0700 (PDT)
In-Reply-To: <20111103182631.GT31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11/03/2011 07:26 PM, Tony Lindgren wrote:
> * Premi, Sanjeev<premi@ti.com>  [111028 06:36]:
>>> -----Original Message-----
>>> From: Premi, Sanjeev
>>> Sent: Thursday, October 13, 2011 9:44 PM
>>> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>>> Cc: Premi, Sanjeev
>>> Subject: [PATCH v2] arm: omap: Fix errors and warnings when
>>> building for one board
>>>
>>> When customizing omap2plus_defconfig to build for only
>>> one board (omap3evm), I came across these warnings and
>>> errors (filenames truncated):
>>
>> Just wanted to check the status of this patch.
>
> Thanks, now with the DT patches merged, I'll apply this into fixes.
> Also moved around the ifdef a little to avoid a build warning for
> when omap3 is not selected.

Great. Consider the question I posted earlier answered then :)


Daniel
