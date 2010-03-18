From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/2] sec: omap sha1 & md5 driver
Date: Thu, 18 Mar 2010 17:36:31 +0200
Message-ID: <20100318153631.GA3877@gandalf>
References: <cover.1268830685.git.dmitry.kasatkin@nokia.com>
 <2f55c827126b6cfc3b09b5b6df7532fc5ea4403e.1268830685.git.dmitry.kasatkin@nokia.com>
 <20100317170805.GB3857@gandalf>
 <4BA23378.8010100@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60223 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab0CRPgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 11:36:12 -0400
Content-Disposition: inline
In-Reply-To: <4BA23378.8010100@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, linux-omap@vger.kernel.org

Hi,

first of all you shouldn't top-post.

On Thu, Mar 18, 2010 at 04:06:48PM +0200, Dmitry Kasatkin wrote:
> omap_sha1_md5_init() only able to get global dd
> no other choice.
> 
> so what is the point to have it as ctx->dd.

the point of not having to global variables is that the driver should
work if with multiples instances of the HW. Besides omap_sha1_md5_init()
is a static function for your driver to use only so you can change that
prototype as much as you want.

> convinced?

no. You should fix the driver before sending it to the public.

-- 
balbi
