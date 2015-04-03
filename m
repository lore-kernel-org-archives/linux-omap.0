From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Sat, 04 Apr 2015 01:08:16 +0300
Message-ID: <551F0F50.1030701@gmail.com>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com> <55197A12.1050009@bitmer.com> <20150330164237.GJ10805@atomide.com> <55198BA4.5010207@bitmer.com> <20150330175051.GK10805@atomide.com> <20150331123233.GA15103@earth> <20150401194734.GT10805@atomide.com> <20150403163553.GA16247@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35639 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbDCWIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 18:08:21 -0400
Received: by widdi4 with SMTP id di4so118271791wid.0
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2015 15:08:20 -0700 (PDT)
In-Reply-To: <20150403163553.GA16247@earth>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

Hi

On  3.04.2015 19:35, Sebastian Reichel wrote:
>
> Maybe an option would be to provide two cpu_v7_switch_mm
> implementations (one with the errata and one without). Then
> the system can start with the simple implementation. Once
> the boot as progressed far enough to know, that the hardware
> is affected by the errata, it could switch to the implementation
> with the flushing.

Or rather the opposite, as if the kernel itself is thumb-compiled, it 
most probably will have no chance to progress enough to switch to the 
correct implementation before hanging.
>
> -- Sebastian
>

Ivo
