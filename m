From: Daniel Mack <zonque@gmail.com>
Subject: Re: Current state of AM33xx patches
Date: Thu, 28 Jun 2012 17:09:08 +0200
Message-ID: <4FEC7394.9030208@gmail.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com> <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com> <4FE9A00B.6010908@ti.com> <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36992 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab2F1PJN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 11:09:13 -0400
Received: by bkcji2 with SMTP id ji2so2109330bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 08:09:12 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>

On 27.06.2012 14:13, Hiremath, Vaibhav wrote:

> Just to clarify from AM335x perspective,
> 
> In case of AM335x, since the patches and complete BasePort support is still
> not present in the Mainline (neither in Linus's tree not in linux-omap), you 
> need to use my Repo (https://github.com/hvaibhav: Closely follows linux-
> omap/master) in order to test something on BeagleBone platform.

Great, that is the information I've been looking for.

Your am335x-upstream-staging branch works for me on a custom AM335x
based board using a custom DT config.

I'll dig through the sources and come back once I know which parts are
missing.


Thanks,
Daniel
