From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: NAND ECC in linux-omap
Date: Wed, 18 Aug 2010 11:45:31 -0400
Message-ID: <AANLkTik4+gApkw5fQ561QnJPLX5ED7oN3oU0P6F0+Gsv@mail.gmail.com>
References: <AANLkTimABq72N98Ca6yJ9FgYnyDpod3qRPoTypkDn-4A@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E8188DB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54584 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab0HRPpc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 11:45:32 -0400
Received: by ewy23 with SMTP id 23so461681ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Aug 2010 08:45:31 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E8188DB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>

On Wed, Aug 18, 2010 at 12:14 AM, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
> [Ghorai]
> 1. Can you send the git tree link and branch you are referring?

git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
branch: pm
95e42b92313f229cbc9fc81bf68fe60aaee515aa

I'm pretty sure this branch tracks linux-omap.  I have not tested
linux-omap yet (git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git:master)

> 2. I am working to support the NAND BCH and not upstream yet, how you apply this patch in PM branch.

What do you mean by upstream?  I'm not sure what NAND changes are in
the above pm branch -- that is what I'm trying to figure out :-)
Perhaps you can suggest if I'm using BCH, etc.

> 3. which x-loader and u-boot you are referring? And no x-loader/ u-boot supports the BCH

I'm using the x-loader/u-boot from for the Gumstix Overo.  My
understanding is that it uses software -- likely not BCH, but I'm not
sure.

Thanks,
Cliff

-- 
=================
http://bec-systems.com
