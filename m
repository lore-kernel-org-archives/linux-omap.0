From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Problem booting Overo Tide at 720MHz
Date: Wed, 28 Dec 2011 09:09:34 -0800
Message-ID: <CAGDS+nn7QUpcbbAxXdph_fr_k8Qir_eES811j3_UfX5AaN0=6Q@mail.gmail.com>
References: <jdfcf8$7ii$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51603 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab1L1RJf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Dec 2011 12:09:35 -0500
Received: by vcbfk14 with SMTP id fk14so9621775vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Dec 2011 09:09:34 -0800 (PST)
In-Reply-To: <jdfcf8$7ii$1@dough.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andre Puschmann <andre.puschmann@tu-ilmenau.de>, linux-omap@vger.kernel.org

On Wed, Dec 28, 2011 at 7:26 AM, Andre Puschmann
<andre.puschmann@tu-ilmenau.de> wrote:
> Hi list,
>
> a couple of days ago I was posting a similar issue where Linux wouldn't
> start after u-boot. I am trying to boot a recent kernel using Steve's
> omap-3.2 branch on an Overo Tide based board.
>
> A recent checkout doesn't boot and hangs after u-boot hands over to the
> kernel. After some digging I figured out that this has something to do
> with the OPP settings for running at 720MHz.
>
> After commenting out omap3_opp_enable_720Mhz() in opp3xxx_data.c the
> kernel boots fine.
>
> Does this work for all others?

Seems to work fine for me.

Give the binary here a try and let me know if it works for you:

http://feeds.sakoman.com/feeds/yocto/images/omap3-multi/current/

If it does then perhaps it is a defconfig issue. If not, then I need
to dig up a Tide to try to reproduce.

Steve
