From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [APPLIED] [PATCH 2/2] OMAP: Zoom2: Fix file system loading	issue
Date: Thu, 18 Jun 2009 10:38:40 -0700
Message-ID: <873a9xqw67.fsf@deeprootsystems.com>
References: <notify-1245247047@atomide.com>
	<87vdmuyhxc.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D1897@dbde02.ent.ti.com>
	<20090618052710.GB8482@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D1C45@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f175.google.com ([209.85.222.175]:64946 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZFRRim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 13:38:42 -0400
Received: by pzk5 with SMTP id 5so487818pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 10:38:45 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F53D1C45@dbde02.ent.ti.com> (Vikram Pandita's message of "Thu\, 18 Jun 2009 19\:02\:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

>>
>>Will revert. I guess we now need two 8250 patches upstream? One for the
>>omap register define, and one for the interrupt flags?
>
> Would be very helpful if you could host these 8250 patches on l-o
> till we get someone to respond to these. This is a critical
> dependency.

FYI... I have these staged in the 'pm-upstream/backports' branch of my
linux-omap-pm repo, since they are needed for PM testing on Zoom2.

Kevin

