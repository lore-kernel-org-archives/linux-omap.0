From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] omap: Ptr "isr_reg" tracked as NULL was dereferenced
Date: Tue, 05 Oct 2010 08:01:12 -0700
Message-ID: <877hhwvg3r.fsf@deeprootsystems.com>
References: <cover.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
	<131d16236d19895323fca2f058d65f1f116bacad.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
	<20101005093206.GB2977@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42755 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab0JEPBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 11:01:18 -0400
In-Reply-To: <20101005093206.GB2977@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Tue, 5 Oct 2010 12:32:06 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "zmc@lurian.net" <zmc@lurian.net>, "a.j.buxton@gmail.com" <a.j.buxton@gmail.com>

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Tue, Oct 05, 2010 at 03:42:10AM -0500, Evgeny Kuznetsov wrote:
>>+	if (!isr_reg) {
>>+		printk(KERN_ERR "FATAL: Incorrect GPIO method %i\n",
>>+				bank->method);
>>+		BUG();
>>+		}
>
> this could be simply:
>
> BUG_ON(!isr_reg);

WARN_ON is better.

A BUG() will panic the kernel and stop everything.  This is not an error
condition that should prevent the entire kernel from running.

>From asm-generic/bug.h:

/*
 * Don't use BUG() or BUG_ON() unless there's really no way out; one
 * example might be detecting data structure corruption in the middle
 * of an operation that can't be backed out of.  If the (sub)system
 * can somehow continue operating, perhaps with reduced functionality,
 * it's probably not BUG-worthy.
 *
 * If you're tempted to BUG(), think again:  is completely giving up
 * really the *only* solution?  There are usually better options, where
 * users don't need to reboot ASAP and can mostly shut down cleanly.
 */
