From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 5/5] omap dts changes for v3.18 merge window
Date: Tue, 23 Sep 2014 22:13:09 -0700
Message-ID: <20140924051309.GB30340@localhost>
References: <pull-1410478051-378788>
 <pull-1410478051-378788-5>
 <20140918201507.GO14505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58145 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbaIXFij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2014 01:38:39 -0400
Received: by mail-pa0-f53.google.com with SMTP id hz1so7832727pad.26
        for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2014 22:38:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140918201507.GO14505@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Sep 18, 2014 at 01:15:08PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140911 16:29]:
> > The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:
> > 
> >   Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/dt-for-v3.18
> > 
> > for you to fetch changes up to d27704d1ec2f9ba06247b402c58a6f2febecef78:
> > 
> >   ARM: dts: OMAP2+: Add sub mailboxes device node information (2014-09-11 11:46:30 -0700)
> > 
> > ----------------------------------------------------------------
> > Changes for .dts files for omaps for v3.18 merge window:
> > 
> > - Updates for gta04 to add gta04a3 model
> > - Add support for Tehnexion TAO3530 boards
> > - Regulator names for beaglebone
> > - Pinctrl related updates for omap5, dra7 and am437
> > - Model name fix for sbc-t54
> > - Enable mailbox for various omaps
> 
> This can cause a minor merge conflict, here's the
> merge resolution for reference.

Thanks, merged all branches now.


-Olof
