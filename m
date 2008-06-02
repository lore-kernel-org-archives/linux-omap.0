From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: zlib error in x-windows on omap osk
Date: Mon, 02 Jun 2008 04:14:40 -0500
Message-ID: <add20420d70b4c01f1339e7f01e03a36@felipebalbi.com>
References: <a1d91fa0805302340q10d4a00dn12087f0cf0e8c3dc@mail.gmail.com> <20080531090335.GA8786@kedavra.cpe.vivax.com.br> <a1d91fa0805312325r643a509es65a7f9243fd4cba6@mail.gmail.com> <75d794f5159cff09c86c89aef69d2776@felipebalbi.com> <a1d91fa0806020206o5657724qb54a65b8dc2c7134@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54138 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYFBJOm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2008 05:14:42 -0400
In-Reply-To: <a1d91fa0806020206o5657724qb54a65b8dc2c7134@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>



On Mon, 2 Jun 2008 14:36:06 +0530, "mohammed shareef" <mdshareef@gmail.com>
wrote:
> Where can i get the development version of zlib? but its is not
> discussed in the tutorial.

$ apt-cache search zlib dev ;-)

Are you using maemo sdk? If they don't have zlib1g-dev you're gonna have
to rebuild the library :-s

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

