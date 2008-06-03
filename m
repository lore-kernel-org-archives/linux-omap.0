From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: user space program for omap gpio
Date: Tue, 3 Jun 2008 15:21:02 +0530
Message-ID: <a1d91fa0806030251w27a36bb3u62cd925845817efa@mail.gmail.com>
References: <a1d91fa0806020958p21d289edrf2c63c8333af9bd4@mail.gmail.com>
	 <20080602174456.GB4964@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:39273 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbYFCJvE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 05:51:04 -0400
Received: by ti-out-0910.google.com with SMTP id b6so492711tic.23
        for <linux-omap@vger.kernel.org>; Tue, 03 Jun 2008 02:51:02 -0700 (PDT)
In-Reply-To: <20080602174456.GB4964@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: omap <linux-omap@vger.kernel.org>

Hi Felipe,

could you give me some useful pointers on how to use the gpio-switch
and ioctl to read and write gpio?

thanx and regards,
Shareef

On Mon, Jun 2, 2008 at 11:14 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Mon, Jun 02, 2008 at 10:28:02PM +0530, mohammed shareef wrote:
>> Hi,
>>
>> i want to access the omap5912 GPIO pins from user space... like
>> reading the pin or writing to it from a user space program. is it
>> possible?
>
> Maybe you can use gpio-switch for reading. But for writing, then you
> would have to write your own module with, maybe, ioctl for writing to
> gpios.
>
> I don't know of any already implemented way for completely handling
> gpios via userland.
>
> --
> Best Regards,
>
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
>
