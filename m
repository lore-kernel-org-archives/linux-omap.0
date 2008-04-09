From: "Kyungmin Park" <kmpark@infradead.org>
Subject: Re: source.mvista links are broken
Date: Thu, 10 Apr 2008 08:23:08 +0900
Message-ID: <9c9fda240804091623x30c10550r7a174c0f78c3b481@mail.gmail.com>
References: <87myo9a3kf.fsf@paris.hilman.org>
	 <010C7BAE6783F34D9AC336EE5A01A08805C303DA@dbde01.ent.ti.com>
	 <010C7BAE6783F34D9AC336EE5A01A08805C30581@dbde01.ent.ti.com>
	 <20080408200839.GA31071@atomide.com>
	 <5d5443650804090008l553e4773i259126743df6b49e@mail.gmail.com>
	 <3B6D69C3A9EBCA4BA5DA60D91302742903F9941B@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:18454 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbYDIXXI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 19:23:08 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2760966wff.4
        for <linux-omap@vger.kernel.org>; Wed, 09 Apr 2008 16:23:08 -0700 (PDT)
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742903F9941B@dlee13.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

On Wed, Apr 9, 2008 at 8:53 PM, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> > I am not able to find x-loader git tree, maintained by Kyungmin Park
>  > of Samsung on source.mvista.com?
>
>  I see the tree there.  There does seem to be some other junk intermixed
>  in it.
>
>  http://source.mvista.com/gittrees/xloader.git/
>
>  There are a couple additional side points about this tree:
>         - Some of his work was folded back into u-boot proper for
>  OneNAND devices.  So there probably is a slow down of usage in this
>  repository.

Yes, I added it to u-boot to make a OneNAND boot image by using one compile.
Of course, you can use the 1KiB boot image separately with other bootloaders.
It has separate directory and can build it.

See reference board, apollon in u-boot tree.

>         - TI has versions with 3430 and other board support on our web
>  site.

Do you have a plan to push it to u-boot tree?

>                 - Along with more boards, there have been some changes
>  we pulled back in from u-boot to support more compilers.  I don't think
>  these ever went back out into this git tree.  It's a matter of who is
>  using it and what its useful for.
>

Thank you,
Kyungmin Park
