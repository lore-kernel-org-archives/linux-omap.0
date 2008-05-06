From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: public git l2 cache off.
Date: Tue, 6 May 2008 10:06:03 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290439AD2F@dlee13.ent.ti.com>
References: <1209575641-25613-1-git-send-email-tony@atomide.com> <20080505131403.93d0a64d.jarkko.nikula@nokia.com> <3B6D69C3A9EBCA4BA5DA60D9130274290439AAD8@dlee13.ent.ti.com> <A9503EED-55EA-4656-AABD-A6DA28F717DA@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51353 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756274AbYEFPGM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 11:06:12 -0400
Content-class: urn:content-classes:message
In-Reply-To: <A9503EED-55EA-4656-AABD-A6DA28F717DA@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org

> Enabling L2 cache was removed from proc-v7.S since was cortex specific
> instead of armv7 specific and u-boot explicitly turns of L2 before
> booting into linux. I made a reverse patch, but my omap3 board doesn't
> boot if I use it:

Our 2.6.24 kernel does something close and boots fine on OMAP3-SDP and Labrador boards.  Which platform did you try on?

I'll try the latest from here on SDP with this and see if it works.  There is also a difference in CR handling.  I had submitted long back a fix to Russell but let it get by me as I didn't have the time to fix per his comments.  I think our version was more correct then the one in place but was still lacking a bit.

[*] It seems possible you could have an issue depending on what your boot loader is or isn't doing for you.

Regards,
Richard W.

