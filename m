From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: CONFIG_CPU_IDLE broken for N900
Date: Tue, 10 Aug 2010 17:23:03 +0300
Message-ID: <20100810172303.31178f2f.jhnikula@gmail.com>
References: <1281442891.17541.26.camel@chotu>
	<1281443718.17541.29.camel@chotu>
	<20100810160324.8df82287.jhnikula@gmail.com>
	<1281447796.17541.33.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48672 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134Ab0HJOXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 10:23:17 -0400
Received: by eya25 with SMTP id 25so3829475eya.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 07:23:16 -0700 (PDT)
In-Reply-To: <1281447796.17541.33.camel@chotu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Kristo Tero (Nokia-MS/Tampere)" <Tero.Kristo@nokia.com>

On Tue, 10 Aug 2010 16:43:16 +0300
Ameya Palande <ameya.palande@nokia.com> wrote:

> > I'm able to reproduce with 2.6.35-rc1 but not with l-o head. It seems
> > that the commit below fixes this.
> > 
> > commit c786bcf12e092802496f1bc440b2b189144612a5
> > Author: Kevin Hilman <khilman@deeprootsystems.com>
> > Date:   Thu Jun 3 17:13:22 2010 +0000
> > 
> >     OMAP3: PM: fix IO daisy chain enable to use PM_WKEN reg
> 
> Just tested it on linux-omap with omap3_defconfig and found that it is
> broken. When kernel bootup is complete, and it switches to user space,
> device hangs. When I disable CPU IDLE, it works..
> 
And I was too fast, problem is there in l-o head but it seems to hang in
different places for me. Above commit removed "Wake up daisy chain
activation failed." error that was slowing down the boot but this issue
seems to be different.

I can boot up to Debian console login but system hangs during user
space boot if I send something over serial. This happend with
omap3_defconfig in l-o head using N900. However, the same kernel works
fine on Beagle. Can this be some silicon dependent issue?


-- 
Jarkko
