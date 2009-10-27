From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [alsa-devel] [PATCH] OMAP: McBSP: Do not use extensive spin locks for dma_op_mode
Date: Tue, 27 Oct 2009 14:04:31 +0200
Message-ID: <200910271404.31484.peter.ujfalusi@nokia.com>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com> <200910271317.52638.peter.ujfalusi@nokia.com> <20091027120009.GA19323@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:65282 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbZJ0MEw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 08:04:52 -0400
In-Reply-To: <20091027120009.GA19323@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>

On Tuesday 27 October 2009 14:00:09 ext Mark Brown wrote:
>=20
> I have to confess that I'm still not entirely clear what the lock is
> supposed to be doing or why it's OK to drop it.  I gather that it's j=
ust
> that dmap_on_mode() doesn't need a lock at all?

In my opinion it does not need a lock.
If the user space is so broken that it is doing different things in par=
allel, I=20
would rather crash the kernel if it is possible to force someone to fix=
 the mess=20
upstairs.
But the lock is not needed, I think it was a result of over-engineering=
=2E


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
