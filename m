From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: omap5912-osk bad magic number
Date: Mon, 2 Jun 2008 21:46:41 +0300
Message-ID: <20080602184641.GA6028@kedavra.cpe.vivax.com.br>
References: <a1d91fa0806021043n2c0c74b6j9dcbf02d3cc05b06@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52876 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbYFBSqV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2008 14:46:21 -0400
Content-Disposition: inline
In-Reply-To: <a1d91fa0806021043n2c0c74b6j9dcbf02d3cc05b06@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>

On Mon, Jun 02, 2008 at 11:13:48PM +0530, mohammed shareef wrote:
> Hi,
> 
> i tried to re-compile my kernel by adding a few features and then
> transfered the new image using u-boot. Unfortunately am getting the
> following error:
> 
> ## Booting image at 00100000 ...
> Bad Magic Number
> OMAP5912 OSK #
> 
> The transfer seems to be complete and proper. all the environment
> variables are also ok. i tried replacing the new image with the
> previous working image. that also fails. could some one tell me whats
> worng?

use uImage instead of zImage

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
