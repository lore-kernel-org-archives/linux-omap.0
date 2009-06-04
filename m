From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Question OMAP3 and PM
Date: Thu, 04 Jun 2009 08:20:14 -0700
Message-ID: <87k53shvpt.fsf@deeprootsystems.com>
References: <dc1d0f40906031714k6ef7aacftc5681c73979d1c11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.216.173]:63244 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189AbZFDPUP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 11:20:15 -0400
Received: by pxi3 with SMTP id 3so728527pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 04 Jun 2009 08:20:16 -0700 (PDT)
In-Reply-To: <dc1d0f40906031714k6ef7aacftc5681c73979d1c11@mail.gmail.com>
 ("Kevyn-Alexandre =?iso-8859-1?Q?Par=E9=22's?= message of "Wed\, 3 Jun 2009
 20\:14\:26 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevyn-Alexandre =?iso-8859-1?Q?Par=E9?= <kevyn.alexandre.pare@gmail.com>
Cc: linux-omap@vger.kernel.org

Kevyn-Alexandre Par=E9 <kevyn.alexandre.pare@gmail.com> writes:

> I'm interested in the PM branch latest and greatest that is working f=
or the
> beagleboard and the omap3evm.
>
> I clone these git for master branch and compile and try without succe=
ss.
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.git=
;a=3Dsummary

The 'master' branch of my tree just tracks Tony's tree.  If you want to
try PM support, then use the branch named 'pm'.

Kevin

> http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.git=
;a=3Dsummary
>
> Beagleboard image was freezing after displaying uncompressed with suc=
cess for
> both branch.
>
> Mistral image was displaying more stuff but no success. I will email =
the output
> later.
>
> First, I'm interested to know which tag should I use? kernel.org is a=
t 2.6.29.4
> for stable should I use these?
>
> Best Regards
>
> kap
>
>
> --
> /**
> =A0* Ask not what your Linux kernel can do for you - ask what you can=
 do for your
> Linux kernel
> =A0* http://www.linuxfoundation.org/en/Kernel_Driver_Statement
> =A0*/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
