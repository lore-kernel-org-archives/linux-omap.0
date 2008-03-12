From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Problems booting Filesystem
Date: Wed, 12 Mar 2008 04:23:57 -0500
Message-ID: <9a7193a562f86236b8006c575eaff2dd@felipebalbi.com>
References: <ae36f8040803111936j1191c784xb8d1c53dbfef8ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59262 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbYCLJX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 05:23:59 -0400
In-Reply-To: <ae36f8040803111936j1191c784xb8d1c53dbfef8ef@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lvcargnini@gmail.com
Cc: "Hunter, Jon" <jon-hunter@ti.com>, linux-omap@vger.kernel.org



On Tue, 11 Mar 2008 23:36:16 -0300, "Lu=C3=ADs Vit=C3=B3rio Cargnini"
<lvcargnini@gmail.com> wrote:
> I did it but the errors persist 8-(, I'm out of ideas I don't know mo=
re
> what
> could be wrong I definitely don't know

Again, please don't top post, it's difficult to track the thread. git
bisect will isolate
the particular that broke omap_nor.c or whatever is broken.

Get the commit hash and put here so we can help you better :-)

--=20
Best Regards,

=46elipe Balbi
http://felipebalbi.com
me@felipebalbi.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
