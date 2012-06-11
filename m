From: Jason Kridner <jkridner@gmail.com>
Subject: Re: Current state of AM33xx patches
Date: Mon, 11 Jun 2012 09:51:21 -0400
Message-ID: <CBFB6F19.95320%jkridner@gmail.com>
References: <4FD5BA4C.9070706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:39461 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab2FKNvs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 09:51:48 -0400
Received: by qabj40 with SMTP id j40so3055153qab.1
        for <linux-omap@vger.kernel.org>; Mon, 11 Jun 2012 06:51:47 -0700 (PDT)
In-Reply-To: <4FD5BA4C.9070706@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, hvaibhav@ti.com, Carlos Hernandez <ceh@ti.com>, Chase Maupin <chase.maupin@ti.com>
Cc: linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jason Kridner <jdk@ti.com>

From: Daniel Mack <zonque@gmail.com>
>Hey,
>
>can anybody give me a quick wrap-up about the current state of AM33xx
>based SoCs in mainline? What are the next steps to get things merged?

There is a wiki page [1] that is intended to provide a summary, but I'm
confident it is not up-to-date.  There is also some automated testing, but
I'm not aware if any of the test results are public and I believe the
coverage is fairly limited.  Hopefully Carlos can chime in with any
information about that.

[1] 
http://processors.wiki.ti.com/index.php/Sitara_Linux_Upstream_Status#AM335x
_Status 


>
>I'm getting involved in a project that is based on a AM3352 and would
>like to provide help where necessary and wanted.

Your help is really appreciated, so thanks in advance.  Hopefully Vaibhav
or Chase can reply with info about any particular subsystems that need
either review or coding.  Conversion to Device Tree is an on-going complex
area where Vaibhav is contributing.

>
>
>Thanks,
>Daniel


