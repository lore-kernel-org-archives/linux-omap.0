From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Can't mount proc filesystem
Date: Sun, 23 Aug 2009 12:33:29 -0600
Message-ID: <4A918B79.5030607@mlbassoc.com>
References: <d9ca78710908231126n5082c0e6tc86acd9448f5e2c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:3912 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933619AbZHWSdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 14:33:42 -0400
In-Reply-To: <d9ca78710908231126n5082c0e6tc86acd9448f5e2c9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tar Gz <bsdraisefromhell@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Tar Gz wrote:
> hi all
> 
> i try to develop linux 2.6.26 kernel with omap patch but when i'm
> booting, i'm enter busybox and running /etc/init.d/rcS
> 
> but failed to mount proc filesystem...i have enabled kernel /rpoc
> filesystems support but it's still can't mounting..any idea?

You should not be running /etc/init.d/rcS manually.  The log
you sent previously shows it has already run.

What makes you think that /proc wasn't mounted?
Why are you running /etc/init.d/rcS by hand?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
