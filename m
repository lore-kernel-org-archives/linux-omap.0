From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Wed, 1 Feb 2012 14:22:11 -0600
Message-ID: <CAB-zwWiDh-NJr26yeVWF6rKShxMSRr2Hdo9oELqCRe=K_UDTMw@mail.gmail.com>
References: <1328058094-28483-1-git-send-email-felipe.contreras@gmail.com>
	<20120201011239.GA797@suse.de>
	<CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
	<4F28AFFE.109@gmail.com>
	<CAMP44s0fxD4kyRrmxcnGOcpnnmr1wd8oFzfZQkCKrT_Zx-kxBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58443 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755191Ab2BAUWM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 15:22:12 -0500
Received: by mail-wi0-f176.google.com with SMTP id hq12so1432639wib.7
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 12:22:11 -0800 (PST)
In-Reply-To: <CAMP44s0fxD4kyRrmxcnGOcpnnmr1wd8oFzfZQkCKrT_Zx-kxBg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Justin P. Mattock" <justinmattock@gmail.com>, Greg KH <gregkh@suse.de>, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, Jiri Kosina <jkosina@suse.cz>, Randy Dunlap <rdunlap@xenotime.net>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>

On Wed, Feb 1, 2012 at 2:11 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Feb 1, 2012 at 5:22 AM, Justin P. Mattock
> <justinmattock@gmail.com> wrote:
>> not sure if I see this warning or not on my machine, but is there a fix for
>> the warning? I would rather see that, than hide it with setting: default y
>> (if that's what its doing!)
>
> No, there's no fix. IIRC Omar said it would not be easy.

Indeed, the ideal would be the ability to turn off the config option
but on the dsp side (when compiling the baseimage), however the
release package only contains binaries given that the source is not
open.

I have been exploring introducing a flag in the shared memory area
which would require a new baseimage release.

Regards,

Omar
