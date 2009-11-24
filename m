From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [ANNOUNCE] PM branch updated to v2.6.32-rc8
Date: Tue, 24 Nov 2009 11:06:43 -0800
Message-ID: <87638zvj24.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f215.google.com ([209.85.219.215]:46324 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933799AbZKXTHK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 14:07:10 -0500
Received: by ewy7 with SMTP id 7so73952ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 11:07:13 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

FYI...

PM branch was rebased to today's linux-omap master branch (currently
v2.6.32-rc8)

As usual, the PM wiki[1] has all the details on using the PM branch as well
as some known issues.

Also note that starting with the official v2.6.32 release, I will be moving
from a continual rebase model to a "re-branch & rebuild" model similar
to how Tony is now managing l-o master.

Kevin

[1] http://elinux.org/OMAP_Power_Management
