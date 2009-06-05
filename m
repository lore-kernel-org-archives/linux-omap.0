From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Script for applying a set of patches from a folder
Date: Fri, 05 Jun 2009 07:38:03 -0700
Message-ID: <8763fad9v8.fsf@deeprootsystems.com>
References: <3284AAA8-73B9-4C4C-95FD-29BC92AFE5A8@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f202.google.com ([209.85.216.202]:62512 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbZFEOiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 10:38:05 -0400
Received: by pxi40 with SMTP id 40so15825pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 07:38:06 -0700 (PDT)
In-Reply-To: <3284AAA8-73B9-4C4C-95FD-29BC92AFE5A8@mac.com> (Elvis Dowson's message of "Fri\, 05 Jun 2009 14\:55\:41 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

> 	Does anyone have a script that will allow me to apply all the
> patches  that are contained in a folder, using the git apply command?
>
> I have hundreds of patches that I want to apply from the dss2 and pm
> branches to the linux-omap-2.6 branch, locally, to bring it upto date,
> to a known state before making specific patches for the overo
> platform.

Not sure exactly what you're trying to do here, but since the PM
branch probably makes up most of those patches, why do you need to
apply them?  Can't you just checkout the pm branch and add the other
patches on top?  e.g.

Create a test branch for your work in progress which is rooted at the
pm branch:

$ git checkout -b wip/test pm

Apply your other patches (dss2, etc.)

$ git am <patches>

Kevin
