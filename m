From: Seth Forshee <seth.forshee@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix error handling in NODE_GetUUIDProps
Date: Mon, 23 Mar 2009 09:38:47 -0500
Message-ID: <20090323143847.GC27379@linux-desktop>
References: <1237814107-19422-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:15729 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264AbZCWOi4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 10:38:56 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1797990rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 07:38:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1237814107-19422-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org

On Mon, Mar 23, 2009 at 03:15:07PM +0200, Ameya Palande wrote:
> From: Seth Forshee <seth.forshee@gmail.com>
> 
> The error handling is ineffective and can lead to an oops.
> 
> Acked-by: Ameya Palande <ameya.palande@nokia.com>
> Signed-off-by: Seth Forshee <seth.forshee@gmail.com>

Ah, hadn't seen this one yet when I sent my previous reply.  Thanks.

Seth
