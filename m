From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: RE: [PATCH 1/4] DSPBRIDGE: Fix macros that break when inside an
	if/else
Date: Tue, 14 Jul 2009 14:02:46 +0300
Message-ID: <1247569366.13580.9.camel@pcarmody-desktop>
References: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
	 <496565EC904933469F292DDA3F1663E602A30E140D@dlee06.ent.ti.com>
Reply-To: ext-phil.2.carmody@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38901 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbZGNLAF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 07:00:05 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602A30E140D@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

On Fri, 2009-07-10 at 01:51 +0200, ext Guzman Lugo, Fernando wrote:
> Thanks for the patch, it only has indentation problems, this is the checkpatch output:
> 
> WARNING: suspect code indent for conditional statements (8, 12)
> #34: FILE: drivers/dsp/bridge/pmgr/wcd.c:152:
> +       if (DSP_SUCCEEDED(status)) {                    \
> +           if (unlikely((src) == NULL) ||              \
> 
> WARNING: line over 80 characters
> #36: FILE: drivers/dsp/bridge/pmgr/wcd.c:154:
> +               unlikely(copy_from_user(dest, src, (elements) * sizeof(*(dest))))) { \
> 
> WARNING: suspect code indent for conditional statements (8, 12)
> #46: FILE: drivers/dsp/bridge/pmgr/wcd.c:164:
> +       if (DSP_SUCCEEDED(status)) {                    \
> +           if (unlikely((dest) == NULL) ||                             \
> 
> WARNING: line over 80 characters
> #48: FILE: drivers/dsp/bridge/pmgr/wcd.c:166:
> +               unlikely(copy_to_user(dest, src, (elements) * sizeof(*(src))))) { \
> 
> total: 0 errors, 4 warnings, 48 lines checked
> 
> Could you please fix that warning please?

I suspect the only way to fix those warnings would either introduce
other warnings, or \
							would \
							lead \
							to \
							utterly \
							unread- \
							able \
							code.

If you check how and why the original TI-originated version of the code
does not follow the linux coding standards, the difficulties we would
have making a warning-free patch of it should be apparent.

Phil

