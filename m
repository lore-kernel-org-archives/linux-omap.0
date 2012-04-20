From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAPDSS: VENC: allow switching venc type at runtime
Date: Fri, 20 Apr 2012 13:49:58 +0300
Message-ID: <CANOLnOP9ciznRxddjFSLuWALme57Woq0p6zP93U3tOFvd9em5w@mail.gmail.com>
References: <1332978312-11959-1-git-send-email-notasas@gmail.com>
	<1334911137.2058.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50793 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752841Ab2DTKt7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 06:49:59 -0400
In-Reply-To: <1334911137.2058.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, Apr 20, 2012 at 11:38 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> On Thu, 2012-03-29 at 02:45 +0300, Grazvydas Ignotas wrote:
>> VENC type (composite/svideo) doesn't have to be fixed by board wirin=
g,
>> it is possible to provide both connectors, which is what pandora doe=
s.
>> Having to recompile the kernel for users who have TV connector types
>> that's don't match default board setting is very inconvenient, espec=
ially
>
> You don't have to recompile the kernel, you could just set the venc t=
ype
> in the board file depending on a boot parameter.
>
>> for users of a consumer device, so add support for switching VENC ty=
pe
>> at runtime over a new sysfs file venc_type.
>
> I really dislike adding new custom sysfs entries for omapdss, and I'd
> like to avoid them if at all possible.

Well some panels already have custom attributes, and venc could be
considered as special panel type, so if it's allowed for panels, why
not allow it for venc?

> Do you need to change the venc
> type during runtime, or is it enough that it can be set during boot?

We need this on runtime, otherwise it causes several issues:
- reboot is required to change the setting, although there is no
technical reason to really require it. This punishes users who want to
try both settings or have both TV types (with a portable device this
may sometimes happen).
- having to provide a way for users to change this in kernel boot
arguments. Note that many pandora users don't know how to handle boot
scripts, so a bootloader menu of some sort would be needed or ability
to edit u-boot environment from Linux, both of which would be
needlessly complicated solutions.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
