From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS: add TPO TD043MTEA1 panel
Date: Wed, 13 Jan 2010 13:33:20 +0200
Message-ID: <1263382400.2087.96.camel@tubuntu.research.nokia.com>
References: <1260559814-25075-1-git-send-email-notasas@gmail.com>
	 <1263372574.2087.93.camel@tubuntu.research.nokia.com>
	 <6ed0b2681001130306p4164fa81ne95f5816f97297ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26116 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab0AMLcN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 06:32:13 -0500
In-Reply-To: <6ed0b2681001130306p4164fa81ne95f5816f97297ec@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-01-13 at 12:06 +0100, ext Grazvydas Ignotas wrote:
> On Wed, Jan 13, 2010 at 10:49 AM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:
> > Hi,
> >
> > Sorry for the long time it took me to check this out. Checkpatch
> > complains about indentation, I think the whole file is indented with
> > spaces, not tabs.
> 
> No it isn't , maybe it's your mail client?
> (latest mainline):
> ./scripts/checkpatch.pl --strict
> /tmp/0001-OMAP-DSS-add-TPO-TD043MTEA1-panel.patch
> total: 0 errors, 0 warnings, 0 checks, 503 lines checked
> 
> Here is the same patch as file (still applies cleanly on mainline):
> http://notaz.gp2x.de/misc/pnd/0001-OMAP-DSS-add-TPO-TD043MTEA1-panel.patch

Strange. Maybe it's my mail client, although every other patch,
including your other patch, was fine. Well... That patch file works
fine. Thanks =).

 Tomi


