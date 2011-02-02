From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/6] omap4: powerdomain: Use intended PWRSTS_* flags
 instead of values
Date: Wed, 2 Feb 2011 11:45:25 +0530
Message-ID: <5a0d09983b1cc3befe85acd85176e289@mail.gmail.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com><1296212688-21951-4-git-send-email-santosh.shilimkar@ti.com>
 <87aaifmdsg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:48597 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752421Ab1BBGPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 01:15:30 -0500
Received: by yxm8 with SMTP id 8so3103272yxm.35
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 22:15:28 -0800 (PST)
In-Reply-To: <87aaifmdsg.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Wednesday, February 02, 2011 6:52 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; b-cousson@ti.com;
> rnayak@ti.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 3/6] omap4: powerdomain: Use intended PWRSTS_*
> flags instead of values
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > IVAHD and ABE power domain logic state is populated using directly
> > value instead of the capability flags.
> >
> > Fix the same.
>
> Again, has this been fixed in the scripts?
>
> For future reference,  It will be helpful to note in the changelog
> that
> this kind of thing has been fixed in the autogen scripts.
>
The power domain scripts was out of sync with code.
And hence its not mentioned.
Benoit has merged the changes from Paul and we will
update this additional change on top of it

Regards,
Santosh
