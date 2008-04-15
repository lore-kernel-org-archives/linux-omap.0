From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: DSP Bridge driver for OMAP3 platform
Date: Tue, 15 Apr 2008 20:48:44 +0530
Message-ID: <5d5443650804150818t77b9e3d4qb6da708ed59ac2d3@mail.gmail.com>
References: <A8E8DDC23969AE4CB38FFF51016C7782028382B0@dlee10.ent.ti.com>
	 <5d5443650804080024k1fa4e12ej45b5f47df3da5572@mail.gmail.com>
	 <A8E8DDC23969AE4CB38FFF51016C77820283875E@dlee10.ent.ti.com>
	 <5d5443650804140158x279b63baybf9de64bbcaab69e@mail.gmail.com>
	 <a0580c510804141455w63b7eb78l51350aaa6856a334@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:14642 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757225AbYDOPSq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 11:18:46 -0400
Received: by nf-out-0910.google.com with SMTP id g13so545948nfb.21
        for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 08:18:45 -0700 (PDT)
In-Reply-To: <a0580c510804141455w63b7eb78l51350aaa6856a334@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org

Hi Eduardo,

On Tue, Apr 15, 2008 at 3:25 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
> Hi Trilok and Hari,
>
>
>  On Mon, Apr 14, 2008 at 4:58 AM, Trilok Soni <soni.trilok@gmail.com> wrote:
>  > Hi Hari,
>  >
>  >
>  >  On Wed, Apr 9, 2008 at 12:33 AM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
>  >  > Hi Trilok,
>  >  >
>  >  >
>  >  >  > 1. Is this a complete re-write of TI internal dspbridge release to
>  >  >  > confirm with linux kernel coding standards? I have heard that internal
>  >  >
>  >  >  > TI bridge is more of layered code and not confirming to Linux kernel
>  >  >  > coding standards.
>  >  >  It is layered code and most of the code is up to date with Linux Kernel
>  >  >
>  >  > Coding standards.
>  >  >
>  >  >  > 2. Does this package has DOFF/COFF format loader?
>  >  >  yes, this package includes DOFF/COFF format loader.
>  >  >
>  >
>  >  Thanks for the reply. As you have opened the doff format. Could you
>  >  please put document explaining the architecture of this format? I
>  >  mean, just a simple table by explaining which block follows whom and
>  >  pointer to other blocks. e.g. section(s) -> string table -> data etc.
>  >
>  >  As I can see that this DOFF loader has been written in kernel-space,
>  >  any special reasons for such design? It could have been simply written
>  >  in userspace and then after parsing and based on cpu-state we could
>  >  have just copied the required sections into targets memory/or bunch of
>  >  co-processors memory.
>
>  I agree here. If I understood correctlu, moving this code to kernel space would
>  only make it complex. If you put this in user land, kernel code will
>  be more independent from formats.
>  Just memory handling code would be necessary into kernel side to
>  implement this feature.
>

Moved CC to linux-omap@vger list. Sorry for replying earlier to old
ML, I totally forgot. Actually by bringing doff loader to userspace,
we can later integrate that with libbfd in binutils, and loading could
become even simpler.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
