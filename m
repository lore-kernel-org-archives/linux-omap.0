From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: Things to do after 2.6.29 gets released
Date: Sat, 21 Mar 2009 15:40:03 +0530
Message-ID: <5d5443650903210310o4210ae79t8f1056d680d6b336@mail.gmail.com>
References: <20090320221230.GA29546@atomide.com>
	 <20090320223858.GA1864@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:36581 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962AbZCUKKF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Mar 2009 06:10:05 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1740963wff.4
        for <linux-omap@vger.kernel.org>; Sat, 21 Mar 2009 03:10:03 -0700 (PDT)
In-Reply-To: <20090320223858.GA1864@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Felipe,

> =A0drivers/input/touchscreen/tsc2005.c =A0 =A0 =A0 | =A0728 +++++++++=
++++++

We did a one round of review with mainline for this driver. Then after
some one from Nokia sent couple of patches to linux-omap mailing list
addressing some of the mainline comments and new features. I don't
have time right now to test those on n810. This driver is very much
clean and there won't be much effort to mainline this if someone is
ready to takeup task of mainlining this.


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
