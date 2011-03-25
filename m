From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH/RFC 00/19] OMAP: voltage layer cleanup and restructure
Date: Fri, 25 Mar 2011 17:02:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103251338580.21987@utopia.booyaka.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com> <87lj04xe2t.fsf@ti.com> <4D8CA8A6.8060102@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44646 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab1CYXCl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 19:02:41 -0400
In-Reply-To: <4D8CA8A6.8060102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi Kevin

you might want to consider renaming 

OMAP3_PRM_VC_VDD_MPU_ID

etc. to something like:

OMAP3_VC_VDD_MPU_ID

and to define those in some vc.h header file.

Also, I'd suggest moving the struct omap_prm_vc_ops assignments out of the 
prm*.c code into the vcXXXX_data.c files, ideally into some initcall, and 
renaming the struct omap_prm_vc_ops to simply struct omap_vc_ops.

As long as the VC's low-level registers are in the PRM, those reads/writes 
should happen through PRM code, IMHO.


- Paul
