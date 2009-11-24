From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 0/9] dspbridge cleanup patches
Date: Tue, 24 Nov 2009 08:54:35 +0200
Message-ID: <1259045675.18407.53.camel@localhost>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63218 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720AbZKXGyk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 01:54:40 -0500
In-Reply-To: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Mon, 2009-11-23 at 18:50 -0600, Omar Ramirez Luna wrote:
> Following patches are cleanups, removing history of files,
> tab spacing and also remove DPC layer.
>=20
> Omar Ramirez Luna (8):
>   DSPBRIDGE: trivial checkpatch fixes
>   DSPBRIDGE: Fix multiline macros to use do while
>   DSPBRIDGE: Use _IOxx macro to define ioctls
>   DSPBRIDGE: trivial cleanup and indentation for io_sm
>   DSPBRIDGE: Remove DPC, create, destroy and schedule wrappers
>   DSPBRIDGE: Remove main DPC wrapper for IO and MMUfault
>   DSPBRIDGE: Remove DPC module from SERVICES layer
>   DSPBRIDGE: Remove DPC object structure
>   DSPBRIDGE: trivial file history cleanup

Look like good clean-ups to me! Although I did not look at the patches
very carefully, just briefly walked through.

I think if you keep doing this, we could add dspbrige to -staging even!

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
