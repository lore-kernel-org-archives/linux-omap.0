From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Compilation: omap-for-linus omap2plus error
Date: Thu, 30 Sep 2010 07:18:38 -0700
Message-ID: <87zkuziabl.fsf@deeprootsystems.com>
References: <4CA409E3.8000800@ti.com>
	<AANLkTinONbTyE4CKDnGfXrco-qy0=u_MpzimpCSnDZr7@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61769 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab0I3OSp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 10:18:45 -0400
Received: by gxk9 with SMTP id 9so796347gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 07:18:44 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA5@dbde02.ent.ti.com>
	(Santosh Shilimkar's message of "Thu, 30 Sep 2010 13:25:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Abraham Arce <abraham.arce.moreno@gmail.com>, "Arce, Abraham" <x0066660@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

>> > Is there any patch missing in omap-for-linus branch?

Short version:

Yes, there are several and the dependencies are taken care of in the
master branch.

Long version: 

There are several changes that are going upstream for 2.6.37 that are
going through other trees (driver core, runtime PM core, i2c core, etc.)
In my tree, I keep these in my pm-backports branch, and for Tony's tree,
he has cherry-picked them into the omap-testing branch so they are
included in l-o master until the merge window opens.

So, even if you cherry pick the one patch, you may not have compile time
problems but you will have other runtime problems due to other
dependencies.  So I strongly recommend just using l-o master.

Kevin
