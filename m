From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: source.mvista links are broken
Date: Wed, 9 Apr 2008 06:53:23 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903F9941B@dlee13.ent.ti.com>
References: <87myo9a3kf.fsf@paris.hilman.org> <010C7BAE6783F34D9AC336EE5A01A08805C303DA@dbde01.ent.ti.com> <010C7BAE6783F34D9AC336EE5A01A08805C30581@dbde01.ent.ti.com> <20080408200839.GA31071@atomide.com> <5d5443650804090008l553e4773i259126743df6b49e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58172 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbYDILxw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 07:53:52 -0400
Content-class: urn:content-classes:message
In-Reply-To: <5d5443650804090008l553e4773i259126743df6b49e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

> I am not able to find x-loader git tree, maintained by Kyungmin Park
> of Samsung on source.mvista.com?

I see the tree there.  There does seem to be some other junk intermixed
in it.

http://source.mvista.com/gittrees/xloader.git/

There are a couple additional side points about this tree:
	- Some of his work was folded back into u-boot proper for
OneNAND devices.  So there probably is a slow down of usage in this
repository.
	- TI has versions with 3430 and other board support on our web
site.
		- Along with more boards, there have been some changes
we pulled back in from u-boot to support more compilers.  I don't think
these ever went back out into this git tree.  It's a matter of who is
using it and what its useful for.

Regards,
Richard W.

