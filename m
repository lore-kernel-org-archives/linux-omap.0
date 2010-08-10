From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: CONFIG_CPU_IDLE broken for N900
Date: Tue, 10 Aug 2010 16:43:16 +0300
Message-ID: <1281447796.17541.33.camel@chotu>
References: <1281442891.17541.26.camel@chotu>
	 <1281443718.17541.29.camel@chotu>
	 <20100810160324.8df82287.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47836 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757694Ab0HJNn2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 09:43:28 -0400
In-Reply-To: <20100810160324.8df82287.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Kristo Tero (Nokia-MS/Tampere)" <Tero.Kristo@nokia.com>

Hi Jarkko,

On Tue, 2010-08-10 at 15:03 +0200, ext Jarkko Nikula wrote:
> On Tue, 10 Aug 2010 15:35:18 +0300
> Ameya Palande <ameya.palande@nokia.com> wrote:
> 
> > > When I enable CONFIG_CPU_IDLE and boot kernel, it hangs around the point
> > > when it switches to user space. I am able to reproduce this for 2.6.35
> > > on linux-omap and linux-2.6 trees.
> > > 
> > > Has anyone else noticed the same thing for omap3 based boards?
> > 
> > Broken on linux-omap-pm as well!
> > 
> I'm able to reproduce with 2.6.35-rc1 but not with l-o head. It seems
> that the commit below fixes this.
> 
> commit c786bcf12e092802496f1bc440b2b189144612a5
> Author: Kevin Hilman <khilman@deeprootsystems.com>
> Date:   Thu Jun 3 17:13:22 2010 +0000
> 
>     OMAP3: PM: fix IO daisy chain enable to use PM_WKEN reg

Just tested it on linux-omap with omap3_defconfig and found that it is
broken. When kernel bootup is complete, and it switches to user space,
device hangs. When I disable CPU IDLE, it works..

Cheers,
Ameya.

