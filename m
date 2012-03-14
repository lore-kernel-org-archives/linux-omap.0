From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v2] OMAPDSS: provide default timings functions for panels
Date: Wed, 14 Mar 2012 18:33:34 +0200
Message-ID: <CANOLnOMAg-gdGPCuR1eR39GzNcK0rqFpfx6hiC2ULgPQ5v4qbA@mail.gmail.com>
References: <1331551631-11420-1-git-send-email-notasas@gmail.com>
	<1331724142.2386.25.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43635 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab2CNQdg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 12:33:36 -0400
In-Reply-To: <1331724142.2386.25.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On Wed, Mar 14, 2012 at 1:22 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> Hi,
>
> On Mon, 2012-03-12 at 13:27 +0200, Grazvydas Ignotas wrote:
>> With this we can eliminate some duplicate code in panel drivers.
>> Also lgphilips-lb035q02, nec-nl8048hl11-01b, picodlp and
>> tpo-td043mtea1 gain support of timings control over sysfs.
>
> I don't like this patch.
>
> Panels usually have a single, fixed timing configuration that should =
be
> used, like the ones you mention above. There's no need to alter the
> timings.

But they often have a range of timings they can tolerate, and that can
be used to alter refresh rate, for example. We do that on pandora to
match graphics drawing rate (or multiples of it) to create a feeling
smoothness.

> But it's true that there's some duplicate code currently in the panel
> drivers. However, adding just simple funcs like you did in this patch
> doesn't work quite properly. There should be locking (for example to
> prevent disabling the panel while timings are being set), and current=
ly
> the locking is panel driver specific.

ok, what about a version of this with .get_timings only then?
This should not need a lock unless panel has a set function, but in
that case panel will be expected to provide safe version of .get and
=2Eset itself.

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
