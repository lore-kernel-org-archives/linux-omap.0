From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Inventra Highspeed Dual Role Controller on TI OMAP 3503
Date: Sun, 28 Nov 2010 05:32:43 -0600
Message-ID: <3524d254e36b505f20c17018a9126a0f@secure211.sgcpanel.com>
References: <43044DC2-2B10-43E3-AE5D-4D53A0337CA5@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36088 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0K1Lcp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Nov 2010 06:32:45 -0500
In-Reply-To: <43044DC2-2B10-43E3-AE5D-4D53A0337CA5@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Fri, 26 Nov 2010 21:36:56 +0400, Elvis Dowson <elvis.dowson@mac.com>
wrote:
> Hi,
>        Is the Inventra Highspeed Dual Role Controller silicon IP
available
>        on the TI OMAP 3503?

yes it is there.

> The kernel config help documentation mentions only TI OMAP 353x and I'm
> not sure if that implies that it isn't present in the TI OMAP 3503
> processor.

that's no official documentation. It's better to check device's datasheet
when you have such questions. Besides, imagine the pain it would be to
patch that Kconfig entry everytime we have a new release of an OMAP
processor. Maybe it would be better to say something like: "available
on many OMAP processors" instead of mentioning each and every one of
them.

-- 
balbi
