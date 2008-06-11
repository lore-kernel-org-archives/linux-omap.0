From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/3] Adding support for OMAP2EVM(Replacing 2430OSK)
Date: Wed, 11 Jun 2008 06:30:35 -0500
Message-ID: <5555135da289dac56cefe2a4ee46ac03@felipebalbi.com>
References: <c656a4d20806110331q4065f7f9i653fe05ebff17cd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42999 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbYFKLai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 07:30:38 -0400
In-Reply-To: <c656a4d20806110331q4065f7f9i653fe05ebff17cd5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org



On Wed, 11 Jun 2008 16:01:12 +0530, "arun c"
<arunedarath@mistralsolutions.com> wrote:
> Hi all,
> 
> The following set of patches adds support for
> Mistral's OMAP2EVM board.
> 
> a) First patch replaces 2430OSK board files with omap2evm
> b) Second patch provides compile support
> c) Third patch completes the name change

The problem will be with the legacy 2430osk, they still provide
the old 1437 machine id, right ? If you remove all of it users
won't be able to boot them until upgrading u-boot.

Besides they carry a different processor (2430 on osk and 2530
on evm). Maybe we keep support for both just sharing all board
files ?

board-n810.c shares everything with board-n800, maybe you
should do something similar?

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

