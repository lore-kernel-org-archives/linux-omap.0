From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/5] staging: tidspbridge: remove unused header
Date: Mon, 30 Jan 2012 11:15:42 -0600
Message-ID: <CAB-zwWjit=Qpt3PCW4fS0OEL_hw6=nLO0a9bemzj8eAEOFGBxw@mail.gmail.com>
References: <cover.1327348286.git.vjaquez@igalia.com>
	<fd9de2a6c650eb4f5cf611ccd7775b6abb73ac35.1327348286.git.vjaquez@igalia.com>
	<CAMP44s0YapTKw6tbz3mnYeBXu1Ut-fPahRNy8U3uSroo_zDWtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMP44s0YapTKw6tbz3mnYeBXu1Ut-fPahRNy8U3uSroo_zDWtA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: =?ISO-8859-1?Q?V=EDctor_Manuel_J=E1quez_Leal?= <vjaquez@igalia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Ernesto Ramos <ernesto@ti.com>, Rene Sapiens <rene.sapiens@ti.com>
List-Id: linux-omap@vger.kernel.org

2012/1/24 Felipe Contreras <felipe.contreras@gmail.com>:
> 2012/1/23 V=EDctor Manuel J=E1quez Leal <vjaquez@igalia.com>:
>> No functional changes.
>>
>> The header file drv_interface.h was only used locally, hence there's=
 no need
>> to have it.
>>
>> Also the only prototyped functions were the file_operations callback=
s, then
>> this commit moves them up to avoid prototyping too.
=2E..
>
> But looks good to me either way.

=46WIW, I agree.

Regards,

Omar
