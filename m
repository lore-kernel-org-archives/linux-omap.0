From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v3 00/12] staging: tidspbridge: various cleanups
Date: Mon, 6 Dec 2010 02:59:02 -0600
Message-ID: <AANLkTi=86Xum25jOhfW_2R-WH8Z57i5taJtteXvu89XM@mail.gmail.com>
References: <1290336390-2581-1-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:45555 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751620Ab0LFI7E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 03:59:04 -0500
Received: by mail-iw0-f170.google.com with SMTP id 2so2662613iwn.15
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 00:59:03 -0800 (PST)
In-Reply-To: <1290336390-2581-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Sapiens Rene <rene.sapiens@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Hi Ionut,

On Sun, Nov 21, 2010 at 4:46 AM, Ionut Nicu <ionut.nicu@gmail.com> wrot=
e:
> This set of patches replaces some of the redundant components of
> the tidspbridge driver, such as:
>
> * wrapper functions for kmalloc/kfree
> * custom bitmap implementation
> * custom linked list implementation (list_head wrapper)
>
> with the standard linux kernel interfaces.
>
> The patches also do some code reorganization for increasing readabili=
ty.
> Most of the changes reduce the code indentation level and simplify th=
e code.
> No functional changes were done.
>
> There are many places in this driver that need this kind of cleanup, =
but
> these patches only fix the functions that were touched while converti=
ng
> the code to use linux bitmap and list_head.

Thanks for your patches, I just fixed the style of some multiline
comments before pushing, since these are very minor fixes I avoided
the noise of resending the patches.

Please remember to follow the Coding Style for multi line comments
whenever you insert back those lines (even if the code was that way).

> Ionut Nicu (12):
> =A0staging: tidspbridge: remove gs memory allocator
> =A0staging: tidspbridge: remove utildefs
> =A0staging: tidspbridge: switch to linux bitmap API
> =A0staging: tidspbridge: remove gb bitmap implementation

Pushed

> =A0staging: tidspbridge: rmgr/node.c code cleanup

Changes requested

> =A0staging: tidspbridge: convert core to list_head

=46ixed a multiline style comment

> =A0staging: tidspbridge: convert pmgr to list_head

=46ixed 2 multiline style comment

> =A0staging: tidspbridge: convert rmgr to list_head
> =A0staging: tidspbridge: remove custom linked list

Pushed

> =A0staging: tidspbridge: core code cleanup

=46ixed multiline style comments

> =A0staging: tidspbridge: pmgr code cleanup

=46ixed multiline style comments

> =A0staging: tidspbridge: rmgr code cleanup

Doesn't apply because of patch "staging: tidspbridge: rmgr/node.c code
cleanup" was not pushed.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
