From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: 8-bit mode for OMAP MMC2
Date: Thu, 26 Mar 2009 10:41:48 +0200
Message-ID: <49CB3FCC.6030507@nokia.com>
References: <dbdb2ea60903251444g53d1a57fi847f9a5a7e833e78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47880 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbZCZIlg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 04:41:36 -0400
In-Reply-To: <dbdb2ea60903251444g53d1a57fi847f9a5a7e833e78@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

twebb wrote:
> Looking through the head of l-o git, I don't see how 8-bit mode is
> turned on for an MMC port - specifically MMC2.  I see where .wires is
> now in place to support 1, 4, or 8, but I can't see anywhere that Bit
> 5 (DW8) of OMAP_HSMMC_CON register is set.  Is support for DW8 in
> place and I just can't find it?

It is queued for 2.6.30 I think

The patch is here:

http://lkml.org/lkml/2009/3/12/343


