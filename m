From: "Rodrigo Vivi" <rodrigo.vivi@gmail.com>
Subject: Re: omapfb driver support of DSS rotation and mirroring
Date: Mon, 17 Mar 2008 15:44:52 -0300
Message-ID: <bdb0025f0803171144k61f01dc7tb06c91ee11dce2aa@mail.gmail.com>
References: <c656a4d20803140251u6627c393qdb6280d317983c2d@mail.gmail.com>
	 <7EAD1AEEA7621C45899FE99123E124A0017B1DC3@dbde01.ent.ti.com>
	 <5d5443650803140720n6402cc7eu1862d3389d9bb25b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.226]:13035 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbYCQSoz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 14:44:55 -0400
Received: by qb-out-0506.google.com with SMTP id e11so5432316qbe.15
        for <linux-omap@vger.kernel.org>; Mon, 17 Mar 2008 11:44:53 -0700 (PDT)
In-Reply-To: <5d5443650803140720n6402cc7eu1862d3389d9bb25b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, arun c <arun.edarath@gmail.com>, linux-omap@vger.kernel.org

My patch to support rotation was already applied to the official git
tree, but it is exclusive to blizzard LCD controller.

I've recently found a bug when blizzard is in power save mode. The
jott (on #maemo at freenode) has fixed it but I don't know why his
patch is not available anymore... It was here: http://sse2.net/rotate/


On Fri, Mar 14, 2008 at 11:20 AM, Trilok Soni <soni.trilok@gmail.com> wrote:
> Hi Arun,
>
>
>  On Fri, Mar 14, 2008 at 5:53 PM, Syed Mohammed, Khasim <khasim@ti.com> wrote:
>  > >
>  >  > I will try porting it to git ( Surely help is needed because i am
>  >  > new), does any body tried it alredy?
>  >  >
>  >  I will be glad to help you on this, just let me know where exactly you want to start with.
>  >
>  >  Probably I will put a ppt or pdf out to all.
>  >
>
>  I think Canola2 and mamona guys have some OMAP GIT patch which does
>  the rotation part successfully with xrandr. Please check with them on
>  maemo-developers mailing list.
>
>  http://labs.vivi.eng.br/blog/?p=40
>
>  --
>  ---Trilok Soni
>  http://triloksoni.wordpress.com
>
>
> --
>  To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Rodrigo Vivi
INdT - Instituto Nokia de Tecnologia
Blog: http://blog.vivi.eng.br
GPG: 0x905BE242 @ wwwkeys.pgp.net
