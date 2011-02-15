From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to
	dev_dbg()
Date: Tue, 15 Feb 2011 14:44:57 +0000
Message-ID: <20110215144457.GD11199@n2100.arm.linux.org.uk>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com> <1297776033-8579-2-git-send-email-dacohen@gmail.com> <4D5A81D8.2080800@ru.mvista.com> <20110215142923.GC11199@n2100.arm.linux.org.uk> <AANLkTin++DGAGT9-nahy1Qm7ASbGm=JjNuPZWZ6XUbcX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52350 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174Ab1BOOpK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 09:45:10 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin++DGAGT9-nahy1Qm7ASbGm=JjNuPZWZ6XUbcX@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, tony@atomide.com, linux-omap@vger.kernel.org, Hiroshi.DOYU@nokia.com, linux-arm-kernel@lists.infradead.org

On Tue, Feb 15, 2011 at 04:36:26PM +0200, David Cohen wrote:
> But pr_cont() would be wrong in case of DEBUG isn't set, isn't it?

Yes.  One other solution you could do is:

	char buf[80], *p = buf;

	buf[0] = '\0';
	for (i = 0; i < ARRAY_SIZE(err_msg); i++)
		if (stat & (1 << i))
			p += scnprintf(p, sizeof(buf) - (p - buf),
					" %s", err_msg[i]);

	dev_dbg(obj->dev, "%s: da:%08x%s\n", __func__, da, buf);

which means that you're then printing the entire string in one go -
and there's no chance for another message to come in the middle of it.

Note that I've placed the ' ' at the beginning of the format string so
that we don't end up with useless trailing space in messages.  Minor
point but it's easy to do here.
