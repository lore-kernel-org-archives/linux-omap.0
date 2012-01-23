From: Paul Walmsley <paul@pwsan.com>
Subject: Re: unhandled fault on reboot/shutdown
Date: Mon, 23 Jan 2012 01:10:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201230038590.13827@utopia.booyaka.com>
References: <4F1CAC71.9080109@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57889 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab2AWIKc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 03:10:32 -0500
In-Reply-To: <4F1CAC71.9080109@redhat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David A. Marlin" <dmarlin@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org

cc linux-pm

Hi

On Sun, 22 Jan 2012, David A. Marlin wrote:

> I experience an unhandled fault on reboot/shutdown using the ARM-OMAP
> kernel-2.6.41.3-1 and later (from Fedora) on a Panda Board.  I have logged a
> bug in:
> 
>   https://bugzilla.redhat.com/show_bug.cgi?id=781552
> 
> which provides the details, and a work around which reverts one commit from
> kernel-3.1.3.
> 
> Please let me know if you require any additional information or have changes
> for me to try.

That commit that you referenced in your bug report -- which is actually 
mainline commit af8db1508f2c9f3b6e633e2d2d906c6557c617f9 ("PM / driver 
core: disable device's runtime PM during shutdown") -- is broken.

Consider leaving it reverted or backporting Alan Stern's commit 
fe6b91f47080eb17d21cbf2a39311877d57f6938 ("PM / Driver core: leave runtime 
PM enabled during system shutdown").


- Paul
