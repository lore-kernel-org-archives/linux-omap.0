From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap regression fixes against v3.17-rc4
Date: Mon, 22 Sep 2014 21:55:29 -0700
Message-ID: <20140923045529.GD7487@localhost>
References: <20140911211018.GJ18849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:59565 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbaIWFDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2014 01:03:52 -0400
Received: by mail-pd0-f182.google.com with SMTP id p10so5573079pdj.13
        for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2014 22:03:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911211018.GJ18849@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Sep 11, 2014 at 02:10:18PM -0700, Tony Lindgren wrote:
> The following changes since commit 2ce7598c9a453e0acd0e07be7be3f5eb39608ebd:
> 
>   Linux 3.17-rc4 (2014-09-07 16:09:43 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-v3.17-rc4
> 
> for you to fetch changes up to 41fc619dd5584d438d1eb673bd82a722d627ad85:
> 
>   bus: omap_l3_noc: Fix connID for OMAP4 (2014-09-11 10:43:39 -0700)
> 
> ----------------------------------------------------------------
> Few regression fixes for omaps for the -rc cycle:
> 
> - Fix for omap_l3_noc bus code
> - Serial console fix for cm-t53
> - NAND timings fix for dra7-evm

Merged, thanks.


-Olof
