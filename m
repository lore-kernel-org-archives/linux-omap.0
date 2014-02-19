From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes against v3.14-rc1
Date: Tue, 18 Feb 2014 16:03:16 -0800
Message-ID: <20140219000316.GB25055@quad.lixom.net>
References: <52fe5291.82a0420a.6f8a.37aaSMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:63999 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbaBSADQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Feb 2014 19:03:16 -0500
Received: by mail-pa0-f47.google.com with SMTP id kp14so17261403pab.6
        for <linux-omap@vger.kernel.org>; Tue, 18 Feb 2014 16:03:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52fe5291.82a0420a.6f8a.37aaSMTPIN_ADDED_BROKEN@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Fri, Feb 14, 2014 at 08:44:31AM -0800, Tony Lindgren wrote:
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/fixes-against-rc1

Pulled. Looks like the following two snuck in that should maybe have been
cleanups instead, but it's not worth respinning over:

> Paul Bolle (2):
>       ARM: OMAP2+: Remove MACH_NOKIA_N800
>       ARM: OMAP2+: Remove legacy macros for zoom platforms


-Olof
