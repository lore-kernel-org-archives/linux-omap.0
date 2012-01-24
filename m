From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/5] staging: tidspbridge: remove unused header
Date: Tue, 24 Jan 2012 19:45:08 +0200
Message-ID: <CAMP44s0YapTKw6tbz3mnYeBXu1Ut-fPahRNy8U3uSroo_zDWtA@mail.gmail.com>
References: <cover.1327348286.git.vjaquez@igalia.com>
	<fd9de2a6c650eb4f5cf611ccd7775b6abb73ac35.1327348286.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fd9de2a6c650eb4f5cf611ccd7775b6abb73ac35.1327348286.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?V=C3=ADctor_Manuel_J=C3=A1quez_Leal?= <vjaquez@igalia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Ernesto Ramos <ernesto@ti.com>, Rene Sapiens <rene.sapiens@ti.com>
List-Id: linux-omap@vger.kernel.org

2012/1/23 V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>:
> No functional changes.
>
> The header file drv_interface.h was only used locally, hence there's =
no need
> to have it.
>
> Also the only prototyped functions were the file_operations callbacks=
, then
> this commit moves them up to avoid prototyping too.

'Also' is a keyword that usually denotes that we are talking about two
patches here: one that reshuffles the code, and another one that
removes the header.

But looks good to me either way.

--=20
=46elipe Contreras
