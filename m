From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 2/2] PLAT-OMAP: MCBSP: Move code mach specific from plat-omap to mach-omap
Date: Tue, 15 Apr 2008 12:41:00 +0300
Message-ID: <a0580c510804150241s5a7cf4d6y8b462772c97ecfa6@mail.gmail.com>
References: <20080414181827.GE4463@kedavra.cpe.vivax.com.br>
	 <1208203891-11225-1-git-send-email-edubezval@gmail.com>
	 <1208203891-11225-2-git-send-email-edubezval@gmail.com>
	 <20080414202338.GJ4463@kedavra.cpe.vivax.com.br>
	 <20080415123805.c2986c15.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:34528 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757395AbYDOJlE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 05:41:04 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3030445waf.23
        for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 02:41:00 -0700 (PDT)
In-Reply-To: <20080415123805.c2986c15.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Jarkko

On Tue, Apr 15, 2008 at 12:38 PM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> On Mon, 14 Apr 2008 23:23:39 +0300
>  "ext Felipe Balbi" <me@felipebalbi.com> wrote:
>
>  > On Mon, Apr 14, 2008 at 04:11:31PM -0400, Eduardo Valentin wrote:
>  > > From: Eduardo Valentin <eduardo.valentin@indt.org.br>
>  > >
>  > > This patch gets ride of ifdefs on mcbsp.c code.
>  > > It moves the mach specific code to mach-omap*.
>  >
>  > It looks ok, checkpatch.pl returns success, boot-test on n810 is fine
>  >
>  Works fine with my ASoC set on N810.

Good to know :)

>
>
>  Jarkko
>



-- 
Eduardo Bezerra Valentin
