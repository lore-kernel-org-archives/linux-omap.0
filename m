From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [ANNOUNCE] updated PM branch, 2.6.32-rc5 + l-o master
Date: Fri, 23 Oct 2009 10:18:46 -0700
Message-ID: <877humghah.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.221.174]:52718 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbZJWRSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 13:18:47 -0400
Received: by qyk4 with SMTP id 4so6811384qyk.33
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 10:18:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I've rebased/updated the PM branch based on current linux-omap master
branch (2.6.32-rc1 based.)

The only changes this time were related to the #include path changes
and the IO_ADDRESS changes.  There were no (intentional) functional
changes.

I've also updated the OMAP Power Management wiki[1], and the 'Current
version' section highlights the changes and supported platforms.

I've also updated the 'mainline plans' section to reflect what is
already in mailine, what is being submitted for the coming merge
window and what is still left in the PM branch.

Kevin

[1] http://elinux.org/OMAP_Power_Management

