From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] OMAP:GPTIMER:1ms tick generation correction
Date: Mon, 21 Jun 2010 07:21:07 -0700 (PDT)
Message-ID: <80021.96115.qm@web180310.mail.gq1.yahoo.com>
References: <4C1F429E.40107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n6-vm0.bullet.mail.gq1.yahoo.com ([98.137.26.79]:33109 "HELO
	n6-vm0.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932608Ab0FUOVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jun 2010 10:21:09 -0400
In-Reply-To: <4C1F429E.40107@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>

Doesn't the generic clock code have logic
to handle such rounding issues?  I'm pretty
sure I remember dealing with that issue for
32K timers on AT91 processors.  If so that
means the setup is done wrong, and is fixable.
 

