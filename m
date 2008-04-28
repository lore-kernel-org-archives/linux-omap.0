From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Android on N810 File System Problem
Date: Mon, 28 Apr 2008 09:24:15 +0300
Message-ID: <20080428092415.0a9f2c90.jarkko.nikula@nokia.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com>
	<48116F5C.9040009@googlemail.com>
	<20080425183605.GA27479@kedavra.cpe.vivax.com.br>
	<87fxt7my4o.fsf@nokia.com>
	<20080427223248.GA5962@kedavra.cpe.vivax.com.br>
	<1209337457.8988.13.camel@mort>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62452 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYD1GXr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 02:23:47 -0400
In-Reply-To: <1209337457.8988.13.camel@mort>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: igor.stoppa@nokia.com
Cc: me@felipebalbi.com, Kalle Valo <kalle.valo@nokia.com>, Dirk Behme <dirk.behme@googlemail.com>, Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org

On Mon, 28 Apr 2008 02:04:17 +0300
"ext Igor Stoppa" <igor.stoppa@nokia.com> wrote:

> > > What about sound?
> > 
> > I'm sure it'll come from alsa-devel soon.
> 
> I also wonder if any kernel to userspace interface has changed since
> we released the FW: that could compromise the execution of system
> services.
> 
Note that my native ALSA implementation doesn't work with our OS200x
because it's using GStreamer - DSP GW - DSP centric audio architecture
[1]. However, I think it should be possible to build GStreamer to run on
top of my work since x86 SDK build is using native ALSA and OSS drivers.

But I assume Android folks doesn't have this restriction :-)


Jarkko

1.
http://maemo.org/development/documentation/how-tos/3-x/multimedia_architecture.html
