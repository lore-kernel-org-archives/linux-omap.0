From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 0/4] Cleanup PRM and CM regbit headers
Date: Fri, 5 Jul 2013 11:13:04 +0530
Message-ID: <51D65CE8.4050004@ti.com>
References: <1372076143-12955-1-git-send-email-rnayak@ti.com> <20130625071428.GC5523@atomide.com> <51C95839.6050307@ti.com> <20130704115819.GJ5523@atomide.com> <51D56743.9080800@ti.com> <alpine.DEB.2.02.1307041627540.6258@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45410 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab3GEFnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jul 2013 01:43:32 -0400
In-Reply-To: <alpine.DEB.2.02.1307041627540.6258@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "benoit.cousson@gmail.com" <benoit.cousson@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 04 July 2013 10:14 PM, Paul Walmsley wrote:
> You mentioned that these patches were generated with some kind of awk=
/grep=20
> scripting.  Can you integrate that in an automated way into the=20
> autogeneration flow?  If the answer is yes, then keep the header.  If=
 the=20
> answer is no, then the header should be dropped.  Beno=EEt, maybe you=
 have=20
> an opinion too?

Ok, I'll try and integrate those scripts so all this can be done in an
automated way even for newer SoCs.

>=20
> As far as whether this should go in -rcX or not, my view is that, as =
a=20
> matter of policy, large changes like this should wait until v3.12.  N=
ow,=20
> having written that, I also was under the impression that the OMAP5=20
> changes weren't going to be sent upstream unless the total diffstat w=
ould=20
> be balanced to roughly zero or negative lines.  As far as I know, tha=
t=20
> didn't happen.  So I guess, v3.11-rc it is...  kernel development by=20
> diffstat :-(

I don't mind these going in -rcX or 3.12, either way is fine.
=20
>=20
> Finally, please repost the whole series once you're done with your=20
> changes, as a non-RFC, along with your pull request (if you plan to s=
end=20
> one).  I guess I should be the one to take these, since I wound up ta=
king=20
> the OMAP5 addition...

:) I thought so too that you should be the one sending the pull.
I will post these out as non-RFC after I do a clean integration into
the autogen scripts, and then you can take a call on sending the pull f=
or
either -rcX or 3.12

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
