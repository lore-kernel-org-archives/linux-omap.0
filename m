From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Latest l-o and usb gadget + NFS root problems
Date: Mon, 30 Mar 2009 14:44:34 +0300
Message-ID: <20090330144434.27f8a30a.jarkko.nikula@nokia.com>
References: <1238146821.28118.36.camel@tubuntu>
	<20090328160605.cd4e6325.jhnikula@gmail.com>
	<gqptap$jje$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48542 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbZC3LoJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2009 07:44:09 -0400
In-Reply-To: <gqptap$jje$1@ger.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "i.mazanov@gmail.com" <i.mazanov@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 30 Mar 2009 08:47:20 +0200
ext Igor Mazanov <i.mazanov@gmail.com> wrote:

> I got stuck in same problem last week. A reason was napi related
> changes in net/core/dev.c. There is a discussion and workaround too
> in LKML,
> 
> Revert "gro: Fix legacy path napi_complete crash", (was: Re: Linux
> 
> http://marc.info/?t=123789988400005&r=1&w=2
> 
Thanks! Seems to help, much more reliable now :-)


Jarkko
