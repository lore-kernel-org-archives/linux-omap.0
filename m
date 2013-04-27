From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] musb regression on omap4 for v3.9
Date: Fri, 26 Apr 2013 17:35:51 -0700
Message-ID: <20130427003551.GB2350@quad.lixom.net>
References: <20130423214544.GN10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:48874 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984Ab3D0Af4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 20:35:56 -0400
Received: by mail-pd0-f181.google.com with SMTP id q10so356549pdj.40
        for <linux-omap@vger.kernel.org>; Fri, 26 Apr 2013 17:35:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130423214544.GN10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Apr 23, 2013 at 02:45:45PM -0700, Tony Lindgren wrote:
> 
> The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:
> 
>   Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9-rc6/fixes-signed
> 
> for you to fetch changes up to f4d7a536faa43f30d87f701268db76b8433a2a8b:
> 
>   ARM: OMAP4: hwmod data: make 'ocp2scp_usb_phy_phy_48m" as the main clock (2013-04-10 13:26:07 -0700)
> 
> ----------------------------------------------------------------
> One MUSB regression fix that I forgot to send earlier. Without
> this MUSB no longer works on omap4 based devices.

Pulled into fixes. I'll send a pull request to Linus tonight, hopefully he
won't cut 3.9-final until later this weekend.


-Olof
