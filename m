From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: zlib error in x-windows on omap osk
Date: Sun, 1 Jun 2008 11:55:11 +0530
Message-ID: <a1d91fa0805312325r643a509es65a7f9243fd4cba6@mail.gmail.com>
References: <a1d91fa0805302340q10d4a00dn12087f0cf0e8c3dc@mail.gmail.com>
	 <20080531090335.GA8786@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:26758 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbYFAGZN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Jun 2008 02:25:13 -0400
Received: by ti-out-0910.google.com with SMTP id b6so149003tic.23
        for <linux-omap@vger.kernel.org>; Sat, 31 May 2008 23:25:11 -0700 (PDT)
In-Reply-To: <20080531090335.GA8786@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: omap <linux-omap@vger.kernel.org>

Hi Felipe,

what is zlib-dev?

as per the tutorials the dependency for the Xlib is only zlib. i have
installed zlib-1.2.2.

thanx and regards,
Shareef

On Sat, May 31, 2008 at 2:33 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Sat, May 31, 2008 at 12:10:31PM +0530, mohammed shareef wrote:
>> Hi all,
>>
>> when i run the autogen script for Xfonf in xlibs for x-windows, i get
>> the following error..
>>
>> checking for gzopen in -lz... no
>> configure: error: *** zlib is required
>> [sbox-ARM-GLIBC: ~/xwin_snapshot/xlibs/Xfont] >
>>
>>
>> i have already installed zlib..
>> all the previous xlib files compiled without any error.
>
> how about zlib-dev?
>
> --
> Best Regards,
>
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
>
