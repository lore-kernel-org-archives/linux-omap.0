From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [Patch] Error when compiling without CONFIG_PM_DEBUG
Date: Fri, 01 Oct 2010 08:15:18 -0700
Message-ID: <871v8ac5bt.fsf@deeprootsystems.com>
References: <8959501C0BAF9F40956CEBAD13FB297F17F38C757C@EINTMBX.einet.ad.eivd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38376 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab0JAPPV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 11:15:21 -0400
Received: by pwj5 with SMTP id 5so575838pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 08:15:20 -0700 (PDT)
In-Reply-To: <8959501C0BAF9F40956CEBAD13FB297F17F38C757C@EINTMBX.einet.ad.eivd.ch>
	(GERBER Patrick's message of "Fri, 1 Oct 2010 14:46:56 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: GERBER Patrick <Patrick.Gerber@heig-vd.ch>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

GERBER Patrick <Patrick.Gerber@heig-vd.ch> writes:

> Hello all,
>
> I have compiled a fresh clone of the linux-omap-2.6 kernel for overo =
and I have linker error.
>
> The serial.c and pm34xx.c files used some variables declared as
> extern. The real declaration of those variables are on pm-debug.c and
> are compiled only with CONFIG_PM_DEBUG. =20

Hi Patric, thanks for the patch.

A couple days ago, a similar patch was posted by Lo=EFc Minier to fix t=
he
same issue, and I'm waiting an updated version of his patch.

> So I have added some #ifdef to correct the error. I don't know if it'=
s
> the best idea but anyway with the attached patch it's work.

Adding #ifdefs in this way is generally not done in the kernel.  For
another example of how to solve the same problem, see the patch from
Lo=EFc.  Also see the '#ifdefs are ugly' section of
Documentation/SubmittingPatches in the kernel source.

Thanks again for contributing your fixes back,

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
