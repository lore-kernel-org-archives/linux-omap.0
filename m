From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention
 issue
Date: Mon, 2 Jul 2012 20:15:36 +0200
Message-ID: <20120702181536.GQ22065@sortiz-mobl>
References: <CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
 <87fw9o32v2.fsf@ti.com>
 <CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
 <20120622103050.GG28472@arwen.pp.htv.fi>
 <87ehp71liv.fsf@ti.com>
 <20120622203645.GD29290@arwen.pp.htv.fi>
 <87d34nfdei.fsf@ti.com>
 <871uku85o8.fsf@ti.com>
 <CA+Bv8XaC64NChdcinrxagRYLZyTG7c05nDYy2EbfH-gfZUxnuw@mail.gmail.com>
 <877gum6o9w.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:3901 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932136Ab2GBSEU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 14:04:20 -0400
Content-Disposition: inline
In-Reply-To: <877gum6o9w.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Russ Dill <russ.dill@gmail.com>, balbi@ti.com, "Munegowda, Keshava" <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, notasas@gmail.com, Paul Walmsley <paul@pwsan.com>

Hi Kevin,

On Mon, Jul 02, 2012 at 10:55:39AM -0700, Kevin Hilman wrote:
> I'm also worried that the owners of this code are running out of time to
> fix these several serious regresions for v3.5.
FYI, I only have one omap-usb fix queued for 3.5 in my for-linus branch, see
http://git.kernel.org/?p=linux/kernel/git/sameo/mfd-2.6.git;a=shortlog;h=refs/heads/for-linus

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
