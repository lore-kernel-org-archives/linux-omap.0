From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [Resend] [PATCH] ARM: OMAP: add RTC support to beagleboard
Date: Thu, 15 May 2008 08:41:09 +0200
Message-ID: <686764F7-B5C9-4E24-9778-FF4630C84B51@student.utwente.nl>
References: <C5EF98DB-8FEF-4AE0-A6BF-7D3FD1E41313@student.utwente.nl> <20080514224253.GE8928@atomide.com> <20080514225636.GE1582@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:39459 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbYEOGlW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 May 2008 02:41:22 -0400
In-Reply-To: <20080514225636.GE1582@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 15 mei 2008, om 00:56 heeft Felipe Balbi het volgende geschreven:
> On Wed, May 14, 2008 at 03:42:53PM -0700, Tony Lindgren wrote:
>> * Koen Kooi <k.kooi@student.utwente.nl> [080513 01:20]:
>>> This patch adds RTC support to the omap3 based beagleboard
>>
>> I've pushed this after tweaking it manually again. It seems it was  
>> for
>> some older kernel? Also you should check your mail client or smtp  
>> server
>> to make sure patches don't wrap like this one is wrapped. It makes it
>> hard to read and apply them.
>
> maybe
>
> $ git send-email --from "Koen Kooi <koen@openembedded.org>" --to linux-omap@vger.kernel.org 
>  file.patch
>
> is enough. At least it doesn't wrap lines ;-)
>
> just set
>
> $ git config --global sendemail.smtpserver mail.openembedded.org
>
> or whatever you use as smtp server.
>
> if you need auth:
>
> $ git config --global sendemail.user <username>
>
> recent versions of git will interactively ask password.

I'll try that next time, thanks.

regards,

Koen



>
>
> -- 
> Best Regards,
>
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIK9sHMkyGM64RGpERAsiCAKCFPIfjKZ+8zE9PpAZngf2B83Y7cQCfTmcs
uhCshhlj574ZKUCaTtmh2VY=
=fQtT
-----END PGP SIGNATURE-----
