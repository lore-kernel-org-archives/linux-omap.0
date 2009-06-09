From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] OMAP3:WDT:Enable IVA, SECURE and minor bugfixes
Date: Tue, 09 Jun 2009 07:45:19 -0700
Message-ID: <87r5xtzcsg.fsf@deeprootsystems.com>
References: <1244495293-17244-1-git-send-email-ubh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:63677 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbZFIOum (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 10:50:42 -0400
Received: by pzk1 with SMTP id 1so23484pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2009 07:50:44 -0700 (PDT)
In-Reply-To: <1244495293-17244-1-git-send-email-ubh@ti.com> (Ulrik Bech Hald's message of "Mon\,  8 Jun 2009 16\:08\:10 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ulrik Bech Hald <ubh@ti.com>
Cc: linux-omap@vger.kernel.org

Ulrik Bech Hald <ubh@ti.com> writes:

> This patch series enables support for IVA and SECURE
> WDTs, available on omap34xx.
> For omap34xx devices the WDT will be accessible 
> (when present) through:
> SECURE:	       /dev/watchdog1
> MPU:	       /dev/watchdog2
> IVA:	       /dev/watchdog3
>
> For devices older than omap34xx only MPU WDT is present
> and will be accessible through /dev/watchdog

I think you should make the MPU WDT the first one since it will always
be present.

> The series also fixes two bugs:
>
> 1) Correct timeout value is not loaded upon opening the
>    watchdog device.
>
> 2) clks are not enabled when accessing registers in probe 

Can you fix these existing bugs in a separate patch before you add the
new features.

Kevin
