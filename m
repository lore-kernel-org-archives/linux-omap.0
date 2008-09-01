From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH 00/34] omap drivers going upstream
Date: Mon, 1 Sep 2008 03:46:31 +0200
Message-ID: <fb249edb0808311846k2bcbef6ah8e003b78c6340f19@mail.gmail.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:33562 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbYIABqc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 21:46:32 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1604672rvb.1
        for <linux-omap@vger.kernel.org>; Sun, 31 Aug 2008 18:46:31 -0700 (PDT)
In-Reply-To: <1220116593-862-1-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

2008/8/30 Felipe Balbi <me@felipebalbi.com>:
<snim>
>  Add omap touchscreen driver

This is just a tsc2101 touchscreen + pin multiplexing, I'm not really
sure it should be upstream (but don't drop it without someone who
knows commenting). I think someone even experimented with using a
tsc2101 driver on the Hx board, but I may be wrong.
Regards
