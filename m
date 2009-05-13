From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: ARM: CONFIG_FRAME_POINTER
Date: Tue, 12 May 2009 22:09:20 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038BD5DEE0@dlee02.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A87396257F0@dlee01.ent.ti.com>
 <87zldhaoco.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37360 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbZEMDJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 23:09:26 -0400
In-Reply-To: <87zldhaoco.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Tuesday, May 12, 2009 6:33 PM
> To: Hunter, Jon

> There was a thread a few weeks back where various folks had noticed
> this as well and we discovered using CodeSourcery 2008q3 fixed the
> problem, but AFAIK, nobody went much farther in the debugging as you
> did.

I did take a quick look at generated code and found parameters were destroyed to tick code.  This caused the timer interrupts to not come.  This resulted in the hang.

If you follow the link and look at attached png you clearly see compiler issue.  I also provided a hack which allowed it to work.  Probably FRAME pointer changes code generation to get rid of issue.

http://marc.info/?l=linux-omap&m=124027585911690&w=2

Regards,
Richard W.
