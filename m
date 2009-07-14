From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: RE: [PATCH 1/4] DSPBRIDGE: Fix macros that break when inside an
	if/else
Date: Tue, 14 Jul 2009 14:20:30 +0300
Message-ID: <1247570430.13580.16.camel@pcarmody-desktop>
References: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
	 <496565EC904933469F292DDA3F1663E602A30E140D@dlee06.ent.ti.com>
	 <1247569366.13580.9.camel@pcarmody-desktop>
	 <7A436F7769CA33409C6B44B358BFFF0C011E5ED158@dlee02.ent.ti.com>
Reply-To: ext-phil.2.carmody@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40900 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbZGNLSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 07:18:22 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C011E5ED158@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Menon, Nishanth" <nm@ti.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

On Tue, 2009-07-14 at 13:05 +0200, ext Menon, Nishanth wrote:
> Phil,
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Phil Carmody
> > Sent: Tuesday, July 14, 2009 6:03 AM
> > 
> > On Fri, 2009-07-10 at 01:51 +0200, ext Guzman Lugo, Fernando wrote:
> > > Thanks for the patch, it only has indentation problems, this is the
> > checkpatch output:
> > >
> > > WARNING: suspect code indent for conditional statements (8, 12)
> > > #34: FILE: drivers/dsp/bridge/pmgr/wcd.c:152:
> > > +       if (DSP_SUCCEEDED(status)) {                    \
> > > +           if (unlikely((src) == NULL) ||              \
> > >
> > > WARNING: line over 80 characters
> > > #36: FILE: drivers/dsp/bridge/pmgr/wcd.c:154:
> > > +               unlikely(copy_from_user(dest, src, (elements) *
> > sizeof(*(dest))))) { \
> > >
> > > WARNING: suspect code indent for conditional statements (8, 12)
> > > #46: FILE: drivers/dsp/bridge/pmgr/wcd.c:164:
> > > +       if (DSP_SUCCEEDED(status)) {                    \
> > > +           if (unlikely((dest) == NULL) ||
> > \
> > >
> > > WARNING: line over 80 characters
> > > #48: FILE: drivers/dsp/bridge/pmgr/wcd.c:166:
> > > +               unlikely(copy_to_user(dest, src, (elements) *
> > sizeof(*(src))))) { \
> > >
> > > total: 0 errors, 4 warnings, 48 lines checked
> > >
> > > Could you please fix that warning please?
> > 
> > I suspect the only way to fix those warnings would either introduce
> > other warnings, or \
> Gentle query: Have we already tried this or is it just a suspicion?

Being an Englishman, I use various forms of irony more than others do;
that particular form's called "litotes". It indeed is not a suspicion -
I tried about 4 or 5 variations, none of which were both readable and
warning-free. In the end I decided that whatever was closest to the
original would be safest.

> > 							would \
> > 							lead \
> > 							to \
> > 							utterly \
> > 							unread- \
> > 							able \
> > 							code.
> > 
> > If you check how and why the original TI-originated version of the code
> > does not follow the linux coding standards, the difficulties we would
> > have making a warning-free patch of it should be apparent.
> 
> Past is past. The idea was not to introduce anymore warning code.

The TI code would trigger the following 4 warnings:
WARNING: suspect code indent for conditional statements (4, 12)
WARNING: line over 80 characters
WARNING: suspect code indent for conditional statements (4, 12)
WARNING: line over 80 characters
4 warnings isn't more than 4 warnings, it's no change - and as I mention
above, in the absence of an easy fix, that was deliberate.

Phil

