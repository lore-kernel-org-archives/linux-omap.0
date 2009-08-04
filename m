From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP PM: How to explicity specify retention mode
Date: Tue, 04 Aug 2009 09:11:10 -0700
Message-ID: <87d47bd0f5.fsf@deeprootsystems.com>
References: <C2056367-0AE7-4429-8B44-38BDE51A5297@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f179.google.com ([209.85.222.179]:44128 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932828AbZHDQLM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 12:11:12 -0400
Received: by pzk9 with SMTP id 9so3242928pzk.21
        for <linux-omap@vger.kernel.org>; Tue, 04 Aug 2009 09:11:13 -0700 (PDT)
In-Reply-To: <C2056367-0AE7-4429-8B44-38BDE51A5297@mac.com> (Elvis Dowson's message of "Mon\, 03 Aug 2009 01\:30\:20 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

> 	How can I explicitly specify retention mode for OMAP PM?

Use the PM branch. ;)

Default is retention in idle and suspend.  To hit off-mode, do

# echo 1 > /sys/power/enable_off_mode

Kevin
