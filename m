From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: omap5912-osk bad magic number
Date: Tue, 03 Jun 2008 06:17:36 -0500
Message-ID: <8e29af8b345a94a4296c121d6bc05268@felipebalbi.com>
References: <a1d91fa0806021043n2c0c74b6j9dcbf02d3cc05b06@mail.gmail.com> <20080602184641.GA6028@kedavra.cpe.vivax.com.br> <a1d91fa0806030133k13b92fe3k6c3eb9733a1b9129@mail.gmail.com> <a1d91fa0806030232k270d7d49jc485f55ea19e57a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51631 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbYFCLRi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 07:17:38 -0400
In-Reply-To: <a1d91fa0806030232k270d7d49jc485f55ea19e57a5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>

Just a tip,

On Tue, 3 Jun 2008 15:02:50 +0530, "mohammed shareef" <mdshareef@gmail.com>
wrote:
>> /tools/mkimage -A arm -O linux -T kernel -C gzip -a 0x10c08000 -e
>> 0x10c08000 -n 'Linux Kernel Image' -d linux.bin.gz uImage.cc

put mkimage in you path (/usr/local/bin, for instance) and issue make
uImage
when building the kernel.

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

