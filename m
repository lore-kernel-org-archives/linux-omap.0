From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] staging: tidspbridge: remove desgin-by-contract macros
Date: Tue, 7 Feb 2012 02:02:56 +0200
Message-ID: <CAMP44s3a7C1JTvrFd8FQxthJYRa4EDEi9sw8Oz=wKcJ_Pfu6dg@mail.gmail.com>
References: <cover.1328563908.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1328563908.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?V=C3=ADctor_Manuel_J=C3=A1quez_Leal?= <vjaquez@igalia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

2012/2/7 V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>:
> These patches removes all the design-by-contract (DBC) macros in the
> tidspbridge.
>
> Also it removes the config option CONFIG_TIDSPBRIDGE_DEBUG.
>
> The patches are applied above these submitted patches:
> http://thread.gmane.org/gmane.linux.kernel/1246081
>
> The main reasons to remove these DBC macros are
>
> * The kernel in general doesn't follow the DBC approach
>
> * They only provide a needless verbosity, since they are available on=
ly
> =C2=A0when CONFIG_TIDSPBRIDGE_DEBUG is enabled. If they were useful t=
hey
> =C2=A0should be left for the dynamic debugging always. So, if they ar=
e not
> =C2=A0used, is dead code at the end, and should be removed.
>
> * Deleting them means less code to maintain
>
> As the Emperor Joseph II told to Mozart in the motion picture Amadeus=
:
> "It's quality work. And there are simply too many notes, that's
> all. Just cut a few and it will be perfect."

The whole series is fine by me :)

Even the warnings that don't depend on DEBUG have been neglected
anyway =3D/ Will send some patches for a few of them soon.

Cheers.

--=20
=46elipe Contreras
