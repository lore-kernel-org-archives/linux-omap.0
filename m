From: pawel cern <pawel.cern@wp.pl>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Thu, 12 Sep 2013 11:12:25 +0000 (UTC)
Message-ID: <loom.20130912T131013-990@post.gmane.org>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com> <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com> <8865776.jqeL1Eqbut@avalon> <CAAwP0s3GmAu8ij37y=5XCs246pWXWfLechaHLZf84+gaPXtwNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57272 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753768Ab3ILPpF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Sep 2013 11:45:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1VK94o-00008w-MA
	for linux-omap@vger.kernel.org; Thu, 12 Sep 2013 17:45:02 +0200
Received: from 213.77.7.67 ([213.77.7.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 12 Sep 2013 17:45:02 +0200
Received: from pawel.cern by 213.77.7.67 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 12 Sep 2013 17:45:02 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Try adding kernel bootargs, lets say: vram=48M omapfb.vram=0:16M,1:16M,2:16M

And see what happens.


