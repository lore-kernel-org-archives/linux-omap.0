From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Problems with RT pathc s in OMAP kernel
Date: Tue, 20 May 2008 15:03:37 -0700
Message-ID: <48334AB9.3020808@mvista.com>
References: <ae36f8040805200742x6de272c5mc9c12ccc798649ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:40988 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934514AbYETWDv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 18:03:51 -0400
In-Reply-To: <ae36f8040805200742x6de272c5mc9c12ccc798649ee@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lvcargnini@gmail.com
Cc: linux-omap@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>

Lu=C3=ADs Vit=C3=B3rio Cargnini wrote:
> Dear fellows:
> After applied the RT patch set in my kernel tree I get the following
> error (RT patch origin: http://rt.wiki.kernel.org/index.php/Main_Page=
)

[...]

> Someone knows how can I fix this ?
> Someone has a patch ?

I've got a series of patches against 2.6.25.4-rt3 that fix compilation=20
on ARM.  Will post shortly.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
