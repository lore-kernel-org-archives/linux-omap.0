From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH 1/3] OMAP PM: Seggregate Voltage layer parameters
Date: Tue, 05 Apr 2011 11:16:19 -0700
Message-ID: <87tyeczhqk.fsf@ti.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
	<1300199622-32500-2-git-send-email-vishwanath.bs@ti.com>
	<87sju1cyfb.fsf@ti.com>
	<97c65feef3328428114e3ec4fc3f021a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57474 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752723Ab1DESQ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 14:16:28 -0400
Received: by mail-iw0-f171.google.com with SMTP id 8so896549iwn.16
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 11:16:22 -0700 (PDT)
In-Reply-To: <97c65feef3328428114e3ec4fc3f021a@mail.gmail.com> (Vishwanath
	Sripathy's message of "Tue, 5 Apr 2011 12:38:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

[...]

> Yes..I am planning to remove these parameters being exposed to board file
> and keep only minimal things (like oscillator ramp and ramp down time) in
> boaord file. We should be able calculate these parameters based on these
> generic parameters.

[...]

> Yes..I am coming up with a more generic way to provide set up latencies.

Great!  Thanks.

For now, please base on my pm-wip/voltdm_b branch.  If you're feeling
adventurous, I've started some VP cleanup/restructure in my
pm-wip/voltdm_c branch as well.

Kevin
