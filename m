From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: [PATCH 1/1] Fix sprz319 erratum 2.1
Date: Tue, 12 Mar 2013 10:11:58 -0400
Message-ID: <CAOd_LFzegrdpJ9W_DDGCVJrCtdm6bsvAwEg5o1g6+Tjb2EMCjQ@mail.gmail.com>
References: <4F4289C2.90707@kynesim.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:52374 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab3CLOL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 10:11:59 -0400
Received: by mail-lb0-f175.google.com with SMTP id n3so12363lbo.34
        for <linux-omap@vger.kernel.org>; Tue, 12 Mar 2013 07:11:58 -0700 (PDT)
In-Reply-To: <4F4289C2.90707@kynesim.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Watts <rrw@kynesim.co.uk>
Cc: paul@pswan.com, linux-omap@vger.kernel.org

On Mon, Feb 20, 2012 at 12:58 PM, Richard Watts <rrw@kynesim.co.uk> wrote:
>
> There is an erratum in DM3730 which results in the
> EHCI USB PLL (DPLL5) not updating sufficiently frequently; this
> leads to USB PHY clock drift and once the clock has drifted far
> enough, the PHY's ULPI interface stops responding and USB
> drops out. This is manifested on a Beagle xM by having the attached
> SMSC9514 report 'Cannot enable port 2. Maybe the USB cable is bad?'
> or similar.
>
> The fix is to carefully adjust your DPLL5 settings so as to
> keep the PHY clock as close as possible to 120MHz over the long
> term; TI SPRZ319e gives a table of such settings and this patch
> applies that table to systems with a 13MHz or a 26MHz clock,
> thus fixing the issue (inasfar as it can be fixed) on Beagle xM
> and Overo Firestorm.
>
> Signed-off-by: Richard Watts <rrw@kynesim.co.uk>

Has any more testing been done with this?  We're running into a
situation where the USB subsystem crashes in a beagleboard xM after
running for a couple hours to a day.  A USB camera is running
continuously during this time.  The error message typically something
like:

[ 2817.415710] hub 1-0:1.0: port 2 disabled by hub (EMI?), re-enabling...
[ 2817.422607] usb 1-2: USB disconnect, device number 2
[ 2817.427886] usb 1-2.1: USB disconnect, device number 3
[ 2817.441986] usb 1-2.4: USB disconnect, device number 4
[ 2817.450134] usb 1-2.5: USB disconnect, device number 5

Thanks,
Cliff

-- 
=================
http://bec-systems.com
