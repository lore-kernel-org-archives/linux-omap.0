From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common init
Date: Tue, 16 Nov 2010 08:16:07 -0800
Message-ID: <8762vxjlbs.fsf@deeprootsystems.com>
References: <1289849261-29767-2-git-send-email-nm@ti.com>
	<20101116122128.5c6cc050@surf> <4CE2710A.3010804@ti.com>
	<20101116134220.1bb818c0@surf> <4CE2A1DA.3020203@ti.com>
	<20101116165039.7e6b8e16@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40298 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682Ab0KPQQM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 11:16:12 -0500
Received: by gyh4 with SMTP id 4so424557gyh.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 08:16:11 -0800 (PST)
In-Reply-To: <20101116165039.7e6b8e16@surf> (Thomas Petazzoni's message of
	"Tue, 16 Nov 2010 16:50:39 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> On Tue, 16 Nov 2010 09:23:06 -0600
> Nishanth Menon <nm@ti.com> wrote:
>
>> my initial implementation had forced board files to call the 
>> opp_init_table, then changed that here:
>> http://marc.info/?l=linux-omap&m=127431810922704&w=2
>> Kevin seemed happy with the change here:
>> http://marc.info/?l=linux-omap&m=127507237109393&w=2
>
> Ok, if Kevin is happy with this solution, fair enough. Sorry for the
> noise, and thanks for your answers.

Yes, I'm not a big fan of the init function called multiple times
either, but I really want to minimize what board files have to do.

Historically, we tend to add all the init functions to every board file,
and this is getting cumbersome to understand and maintain.  What we need
is for common code to take care of sensible defaults for all boards, and
then only boards with non-default behavior have to have custom code.

Kevin


