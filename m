From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Unbalanced IRQ wake disable during resume from static suspend
Date: Thu, 2 Dec 2010 01:14:00 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012020112540.2515@utopia.booyaka.com>
References: <alpine.DEB.2.00.1012020057550.2515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38347 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab0LBIOB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 03:14:01 -0500
In-Reply-To: <alpine.DEB.2.00.1012020057550.2515@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Govindraj <govindraj.ti@gmail.com>
Cc: khilman@deeprootsystems.com

On Thu, 2 Dec 2010, Paul Walmsley wrote:

> On current linux-omap master (commit 
> 7fd1cffc56ca9944fec583eb2ecda5ce88b36bff "Linux-omap rebuilt: Updated to 
> -rc4"), when resuming from static suspend, several "Unbalanced IRQ 
> wake disable" warnings are generated, one for each of the serial ports.
> This is on Beagle 35xx rev C2.

Just to follow up on this, these messages are not logged when 
/sys/devices/platform/omap/omap-hsuart.*/tty/ttyO*/power/wakeup are set to 
'disabled'.

Also this is with omap2plus_defconfig.


- Paul
