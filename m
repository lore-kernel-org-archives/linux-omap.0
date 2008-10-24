From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/6] Integrate the twl4030 power code into new twl4030 mfd
Date: Fri, 24 Oct 2008 15:39:05 -0700
Message-ID: <87skql62k6.fsf@deeprootsystems.com>
References: <1224491876-4353-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:62437 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbYJXWjJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 18:39:09 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1087367rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Oct 2008 15:39:08 -0700 (PDT)
In-Reply-To: <1224491876-4353-1-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Mon\, 20 Oct 2008 11\:37\:50 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> This patchset integrates the twl4030 power code into the new twl4030 mfd framework.
> The scripts will be moved to the board specific data.
>
> Peter 'p2' De Schrijver (6):
>   Add defines and data types for twl4030.
>   Move existing TWL4030 code to drivers/mfd
>   Hook twl4030 power code into twl4030 core.
>   3430sdp and ldp use custom twl4030 power scripts.
>   Generic twl4030 power script for 3430 based boards.
>   omap3 evm, beagle and overo use the generic twl4030 script

Tony,

This looks good to me.  Rather than pull this into pm-<next>, this
could go straight into linux-omap, and then Peter should submit to
mainline.

Kevin


