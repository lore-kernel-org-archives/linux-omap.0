From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/4] DSPBRIDGE: Fix macros that break when inside an
	if/else
Date: Tue, 14 Jul 2009 06:05:28 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C011E5ED158@dlee02.ent.ti.com>
References: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
	 <496565EC904933469F292DDA3F1663E602A30E140D@dlee06.ent.ti.com>
 <1247569366.13580.9.camel@pcarmody-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41701 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbZGNLFj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 07:05:39 -0400
In-Reply-To: <1247569366.13580.9.camel@pcarmody-desktop>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Phil,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Phil Carmody
> Sent: Tuesday, July 14, 2009 6:03 AM
> 
> On Fri, 2009-07-10 at 01:51 +0200, ext Guzman Lugo, Fernando wrote:
> > Thanks for the patch, it only has indentation problems, this is the
> checkpatch output:
> >
> > WARNING: suspect code indent for conditional statements (8, 12)
> > #34: FILE: drivers/dsp/bridge/pmgr/wcd.c:152:
> > +       if (DSP_SUCCEEDED(status)) {                    \
> > +           if (unlikely((src) == NULL) ||              \
> >
> > WARNING: line over 80 characters
> > #36: FILE: drivers/dsp/bridge/pmgr/wcd.c:154:
> > +               unlikely(copy_from_user(dest, src, (elements) *
> sizeof(*(dest))))) { \
> >
> > WARNING: suspect code indent for conditional statements (8, 12)
> > #46: FILE: drivers/dsp/bridge/pmgr/wcd.c:164:
> > +       if (DSP_SUCCEEDED(status)) {                    \
> > +           if (unlikely((dest) == NULL) ||
> \
> >
> > WARNING: line over 80 characters
> > #48: FILE: drivers/dsp/bridge/pmgr/wcd.c:166:
> > +               unlikely(copy_to_user(dest, src, (elements) *
> sizeof(*(src))))) { \
> >
> > total: 0 errors, 4 warnings, 48 lines checked
> >
> > Could you please fix that warning please?
> 
> I suspect the only way to fix those warnings would either introduce
> other warnings, or \
Gentle query: Have we already tried this or is it just a suspicion?


> 							would \
> 							lead \
> 							to \
> 							utterly \
> 							unread- \
> 							able \
> 							code.
> 
> If you check how and why the original TI-originated version of the code
> does not follow the linux coding standards, the difficulties we would
> have making a warning-free patch of it should be apparent.

Past is past. The idea was not to introduce anymore warning code.

Regards,
Nishanth Menon

