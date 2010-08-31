From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/2] cbus: Fix compile by converting ioctl calls to
 =?UTF-8?Q?unlocked=5Fioctl=20calls?=
Date: Tue, 31 Aug 2010 06:18:55 -0500
Message-ID: <dd056c7f8f73d208312577a1d0d450dd@secure211.sgcpanel.com>
References: <1283249351-24487-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48882 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756973Ab0HaLS6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 07:18:58 -0400
In-Reply-To: <1283249351-24487-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tue, 31 Aug 2010 13:09:11 +0300, Jarkko Nikula <jhnikula@gmail.com>
wrote:
> Locked .ioctl is gone from struct file_operations by commit b19dd42
> so these cbus drivers don't compile. Also it seems there is no need for
BKL
> anyway in these drivers.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Felipe Balbi <me@felipebalbi.com>

FWIW,

Acked-by: Felipe Balbi <me@felipebalbi.com>

-- 
balbi
