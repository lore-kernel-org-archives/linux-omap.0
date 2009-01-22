From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Complete Beagleboard support
Date: Thu, 22 Jan 2009 09:53:23 +0200
Message-ID: <200901220953.23657.peter.ujfalusi@nokia.com>
References: <5e088bd90901202305m26900888jcaa2b0ec57d3fab1@mail.gmail.com> <5e088bd90901210640v4ce21f8clae9469b60226a6f0@mail.gmail.com> <5e088bd90901210835neb0d8f1s309d4668cf444cc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24969 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbZAVHxe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 02:53:34 -0500
In-Reply-To: <5e088bd90901210835neb0d8f1s309d4668cf444cc0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: ext Steve Sakoman <sakoman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>


On Wednesday 21 January 2009 18:35:54 ext Steve Sakoman wrote:
> I did a quick mplayer test and was able to play an mp3 with this patc=
h
> applied to linux-omap top of tree.

That's great!
Not that I had any objections to the patch itself, but I was not sure i=
f it is=20
working. As Mark pointed out - and I was not aware off - that all endpo=
ints=20
are on by default and has to be explicitely marked as not connected if =
they=20
are not in use.

> Hardware was Beagle Rev C1D
>
> Steve

--=20
P=E9ter

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
