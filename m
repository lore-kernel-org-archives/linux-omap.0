From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap eac.c file
Date: Thu, 22 Oct 2009 14:00:00 -0700
Message-ID: <20091022210000.GW16230@atomide.com>
References: <e7c6a05e0910220040l388cc549ia360db220ee4a9bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60219 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbZJVU75 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 16:59:57 -0400
Content-Disposition: inline
In-Reply-To: <e7c6a05e0910220040l388cc549ia360db220ee4a9bf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: linux-omap@vger.kernel.org

* Belisko Marek <marek.belisko@gmail.com> [091022 00:40]:
> Hi,
> 
> I'm trying to figure out where are omap2420 eac codec code.
> In 2.6.25 there was for N800 written in sound/arm/eac.c but in latest
> tree there
> is no such file. I'm trying to get some clue because I would like to write
> similar for omap850.

We've dropped all the old legacy code from the linux-omap tree,
and only queue things that are going to mainline now.

For the old code, you should be able to find it in one of the
earlier branches, like omap-2.6.30 maybe.

Tony
