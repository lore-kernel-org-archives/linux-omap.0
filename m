From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix for
 undefined reference to 'omap2_prm_read_mod_reg'
Date: Sat, 8 Jan 2011 02:52:33 +0530
Message-ID: <d252887d2246f5e31e3763666ddc4958@mail.gmail.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com><1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com><alpine.DEB.2.00.1101061056340.22048@utopia.booyaka.com><e194160102cb8b695465c81eea6582fc@mail.gmail.com>
 <87r5comn6o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45880 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751972Ab1AGVWt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 16:22:49 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so18216654fxm.5
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 13:22:48 -0800 (PST)
In-Reply-To: <87r5comn6o.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Saturday, January 08, 2011 2:44 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; linux-arm-
> kernel@lists.infradead.org; Paul Walmsley
> Subject: Re: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix
> for undefined reference to 'omap2_prm_read_mod_reg'
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> [...]
>
> >> I think it would be best to use WARN() on these, rather than
> >> WARN_ONCE().  That's because these could be called from different
> >> parts of the code base, and the stack backtrace will help someone
> >> figure out all the code that needs to be fixed.
> >>
> >> Once you do that, this patch is
> >>
> >> Acked-by: Paul Walmsley <paul@pwsan.com>
> >>
>
> > With WARN() instead of WARN_ONCE() and Paul's ack, here
> > is an updated patch.
>
> Thanks, will queue for .38-rc cycle.
>
> I'll again plead for working on your git-send-email setup.  It looks
> like your using outlook.  The inline patch is wrapped (as outlook
> almost
> always does.)  The attached version applied fine, but the strong
> preference is for a single inline patch.
>
Its google mail now a days. I thought it will wrap and
hence attached the version.

Fully agree with inline patch but as this one was minor
update I skipped it.

Regards
Santosh
